import "dart:io";

import "package:alert_banner/types/enums.dart";
import "package:alert_banner/widgets/alert.dart";
import "package:alpha_flutter_project/qrcode_list/src/bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:equatable/equatable.dart";
import "package:localization_service/localization_service.dart";
import "package:open_file/open_file.dart";
import "package:path_provider/path_provider.dart";
import "package:permission_handler/permission_handler.dart";
import 'package:flutter_downloader/flutter_downloader.dart';
import "../../widgets/common/alert_banner_child.dart";

part "qrcode_list_local_event.dart";
part 'qrcode_list_local_state.dart';
class QrcodeListLocalBloc extends Bloc<QrcodeListLocalEvent,QrcodeListLocalState>{
  QrcodeListLocalBloc():super(QrcodeListLocalState()){
    on<QrcodeListLocalDownloadPdfRequested>(_onDownloadPdfRequested);
    on<QrcodeListLocalDownloadPictureLinkRequested>(_onDownloadPictureRequested);
  }



  _onDownloadPdfRequested(QrcodeListLocalDownloadPdfRequested event,Emitter<QrcodeListLocalState> emit) async {
    try{
      //Initialize
      await FlutterDownloader.initialize();
      // Check and request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        showAlertBanner(event.context,()=>print("TAPPED"), AlertBannerChild(text: event.context.tr("Permission denied !")), alertBannerLocation: AlertBannerLocation.top
        );
        return;
      }
      // Get the download directory
      final downloadPath = await getDownloadPath();
      final savePath = '${downloadPath}/google_review_qrcode_${DateTime.now().toString()}.pdf';
      final taskId = await FlutterDownloader.enqueue(
          url: event.context.read<QrcodeListRemoteBloc>().state.items[event.index].downloadPdfLink.url,
          savedDir: savePath.substring(0, savePath.lastIndexOf('/')),
          fileName: savePath.substring(savePath.lastIndexOf('/') + 1),
          showNotification: true,
          openFileFromNotification: true,
      );

      // Listen for download completion
      FlutterDownloader.registerCallback((id, status, progress) {
        if (id == taskId && status == DownloadTaskStatus.complete) {
          showAlertBanner(event.context,()=>print("TAPPED"), AlertBannerChild(text: event.context.tr("Download completed !"),color: Colors.green,), alertBannerLocation: AlertBannerLocation.top);
          OpenFile.open(savePath);
        }
      });

    }catch(err){
      print(err);
    }
  }

  _onDownloadPictureRequested(QrcodeListLocalDownloadPictureLinkRequested event,Emitter<QrcodeListLocalState> emit) async {
    try{
      print("local");
    }catch(err){

    }
  }

  Future<String> getDownloadPath() async {
    if (Platform.isAndroid) {
      // For Android, try to get external storage first
      try {
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          // Create a Downloads folder if it doesn't exist
          final downloadFolder = Directory('${directory.path}/Download');
          if (!await downloadFolder.exists()) {
            await downloadFolder.create(recursive: true);
          }
          return downloadFolder.path;
        }
      } catch (e) {
        print("Error getting external storage: $e");
      }
      // Fallback for Android if external storage isn't available
      return (await getApplicationDocumentsDirectory()).path;
    } else if (Platform.isIOS) {
      // For iOS, use documents directory
      return (await getApplicationDocumentsDirectory()).path;
    }
    throw UnsupportedError('Unsupported platform');
  }
}
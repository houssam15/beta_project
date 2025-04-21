part of "qrcode_list_local_bloc.dart";

sealed class QrcodeListLocalEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class QrcodeListLocalDownloadPdfRequested extends QrcodeListLocalEvent{
  final BuildContext context;
  final int index;
  QrcodeListLocalDownloadPdfRequested({required this.context,required this.index});
}

class QrcodeListLocalDownloadPictureLinkRequested extends QrcodeListLocalEvent{
  final int index;
  QrcodeListLocalDownloadPictureLinkRequested(this.index);
}
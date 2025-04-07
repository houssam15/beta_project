import 'dart:async';
import 'dart:io';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:file_chunked_uploader/src/mock_data/upload_document.dart';
import 'package:file_chunked_uploader/src/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

///This class handle large file upload
class FileChunkedUploader<Response extends UploadResponse>{
    final Config config;
    Response? uploadResult;
    final Response Function(Map<String, dynamic> json, {String? token}) fromJson;
    FileChunkedUploader(this.config,this.fromJson);

    ///This function upload large images or videos to server , by split it to equal chunks
    ///
    /// - Send a uuid that make server able to group all uploaded chunks to a valid file under header property File-Uuid
    ///
    /// - Send origin file name to server under header property File-Name
    Stream<int> upload(File file,{Map<String,dynamic>? data}) async*{
        final StreamController<int> progressController = StreamController<int>();

            final dio = Dio(BaseOptions(
                baseUrl: config.baseUrl.toString(),
                headers: {
                'Content-Type': config.contentType,
                'File-Name':file.uri.pathSegments.last,
                'File-uuid': _getUuid(),
                'Authorization':"Bearer ${config.authorizationToken}"
                },
                connectTimeout: Duration(seconds: 3), // 3 seconds for connection
                receiveTimeout: Duration(seconds: 3), // 3 seconds for receiving data
                sendTimeout: Duration(seconds: 3), // 3 seconds for sending data
            ));
            final uploader = ChunkedUploader(dio);
            // using data stream
            uploader.upload(
                fileName: file.uri.pathSegments.last,
                fileSize: file.lengthSync(),
                fileDataStream: file.openRead(),
                maxChunkSize: config.chunkMaxSize,
                path: config.path,
                data: data,
                onUploadProgress: (progress) {
                    // ✅ Send progress updates
                    if(progress>1) {
                        progressController.add((100).toInt());
                    } else {
                        progressController.add((progress * 100).toInt());
                    }
                },
            ).then((response) {
                uploadResult = fromJson(response?.data,token:config.authorizationToken);
                //uploadResult = UploadDocumentResponse().fromJson(UploadDocumentMockData.uploadDocumentForPublication[0]);
                progressController.close();
            }).catchError((error) {
                if (kDebugMode) print(error);
                    progressController.addError(error);
                    progressController.close();
            });

        yield* progressController.stream;
    }

    ///Generate uuid to identify group of chunks for a file
    String _getUuid() {
        return Uuid().v4();
    }
}
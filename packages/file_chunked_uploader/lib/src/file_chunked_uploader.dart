import 'dart:async';
import 'dart:io';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:file_chunked_uploader/src/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

///This class handle large file upload
class FileChunkedUploader{
    final Config config;

    FileChunkedUploader(this.config);

    ///This function upload large images or videos to server , by split it to equal chunks
    ///
    /// - Send a uuid that make server able to group all uploaded chunks to a valid file under header property File-Uuid
    ///
    /// - Send origin file name to server under header property File-Name
    Stream<int> upload(File file) async*{
        final StreamController<int> progressController = StreamController<int>();

            final dio = Dio(BaseOptions(
                baseUrl: config.baseUrl,
                headers: {
                'Content-Type': config.contentType,
                'File-Name':file.uri.pathSegments.last,
                'File-uuid': _getUuid()
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
                onUploadProgress: (progress) {
                    progressController.add((progress*100).toInt()); // ✅ Send progress updates
                },
            ).then((response) {
                    //progressController.add(100); // ✅ Send 100% only if no error
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
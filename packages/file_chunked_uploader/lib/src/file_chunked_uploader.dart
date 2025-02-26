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
        try{
            final dio = Dio(BaseOptions(
                baseUrl: config.baseUrl,
                headers: {
                'Content-Type': config.contentType,
                'File-Name':file.uri.pathSegments.last,
                'File-uuid': _getUuid()
                }
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
                progressController.add(100); // ✅ Complete progress at 100%
                progressController.close(); // ✅ Close stream when done
            }).catchError((error) {
                if (kDebugMode) print(error);
                progressController.addError(error); // Pass error to stream
                progressController.close();
            });
        }catch(err){
            if (kDebugMode) print(err);
            progressController.addError(err);
            progressController.close();
        }

        yield* progressController.stream;
    }

    ///Generate uuid to identify group of chunks for a file
    String _getUuid() {
        return Uuid().v4();
    }
}
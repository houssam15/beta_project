import "dart:io";
import "package:file_uploader_permissions_handler/file_uploader_permissions_handler.dart" hide PermissionsState ;
import "package:flutter/foundation.dart";
import "package:local_file_picker/local_file_picker.dart" as local_file_picker;
import "models/models.dart";
import "package:file_chunked_uploader/file_chunked_uploader.dart";

/*
Messages :
- permissions granted successfully
- unable to load files from device
- please give us access to the permissions below :
- file type not supported
- user cancel operation
- file picked successfully
*/

class FileUploaderRepository{
    final FileUploaderPermissionsHandler _fileUploaderPermissionsHandler;
    final local_file_picker.LocalFilePicker _localFilePicker;
    late FileChunkedUploader _fileChunkedUploader;
    final GlobalParams globalParams;

    FileUploaderRepository({
        FileUploaderPermissionsHandler? fileUploaderPermissionsHandler,
        local_file_picker.LocalFilePicker? localFilePicker,
        FileChunkedUploader? fileChunkedUploader,
        required this.globalParams
    })
    :_fileUploaderPermissionsHandler = fileUploaderPermissionsHandler ?? FileUploaderPermissionsHandler(),
     _localFilePicker = localFilePicker ?? local_file_picker.LocalFilePicker(){
        _fileChunkedUploader = fileChunkedUploader??FileChunkedUploader(
            Config(
                baseUrl: globalParams.fileChunkedUploadBaseUrl,
                path: globalParams.fileChunkedUploadPath,
                chunkMaxSize: globalParams.fileChunkedUploadMaxChunkSize,
                contentType: globalParams.fileChunkedUploadContentType
            )
        );
     }

    Future<PermissionsState> requestPermissions() async{
        final result = await _fileUploaderPermissionsHandler.requestPermissions();
        return PermissionsState(
            status: result.isAllPermissionsGranted ? PermissionsStatus.granted:PermissionsStatus.denied,
            message: result.isAllPermissionsGranted?"permissions granted successfully":(
                !result.isPermissionsNeedOpenSettings?"unable to load files from device":"please give us access to the permissions below :"
            ),
            openSettingDialog: result.isPermissionsNeedOpenSettings,
            permissionsNotRequestedYet: result.permissionsNotRequestedYet
        );
    }

    Future<bool> openSettingsToGrantPermissions()async{
        final result  = await _fileUploaderPermissionsHandler.openSettingsToGrantpermissions();
        return true;
    }

    Future<LocalFile> getFileFromSource(UploadSourceType source,MediaType type) async{
        local_file_picker.LocalFile file = await _localFilePicker.pickFile(source.toLocalFileSource(),type.toLocalFileType());
        return LocalFile(
            isSuccess: file.status==local_file_picker.LocalFileStatus.picked,
            isCanceled:file.status==local_file_picker.LocalFileStatus.canceled,
            isError:file.status==local_file_picker.LocalFileStatus.failed,
            source: file.fileSource.toUploadSourceType(),
            type: file.fileType.toMediaType(),
            file:file.file,
            message:file.message
        );
    }

    Stream<int> uploadFileToServer(File file) async* {
            yield* _fileChunkedUploader.upload(file).handleError((error){
                if(kDebugMode) print("UploadFileToServer error : $error");
                throw Exception("Server unavailable");
            });
    }

}
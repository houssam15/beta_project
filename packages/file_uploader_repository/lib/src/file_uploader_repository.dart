import "dart:io";
import "package:file_uploader_permissions_handler/file_uploader_permissions_handler.dart" hide PermissionsState ;
import "package:local_file_picker/local_file_picker.dart" as local_file_picker;
import "models/models.dart";
import "package:file_chunked_uploader/file_chunked_uploader.dart";

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


    List<String> get _messages => [
        "permissions granted successfully",
        "unable to load files from device",
        "please give us access to the permissions below :",
        "user cancel operation",
        "file picked successfully",
        "unknown error"
    ];

    Future<PermissionsState> requestPermissions() async{
        final result = await _fileUploaderPermissionsHandler.requestPermissions();
        return PermissionsState(
            status: result.isAllPermissionsGranted ? PermissionsStatus.granted:PermissionsStatus.denied,
            message: result.isAllPermissionsGranted?_messages[0]:(
                !result.isPermissionsNeedOpenSettings?_messages[1]:_messages[2]
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
            message:file.message=="USER_CANCEL_OPERATION"?_messages[4]
                : (file.message=="FILE_PICKED_SUCCESSFULLY"
                     ? _messages[5]
                     : _messages[6]
                  )
        );
    }

    Stream<int> uploadFileToServer(File file) async* {
        yield* _fileChunkedUploader.upload(file);
    }

}
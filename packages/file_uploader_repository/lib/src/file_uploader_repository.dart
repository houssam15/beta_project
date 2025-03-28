import "dart:io";
import "package:file_uploader_permissions_handler/file_uploader_permissions_handler.dart" hide PermissionsState ;
import "package:flutter/foundation.dart";
import "package:local_file_picker/local_file_picker.dart" as local_file_picker;
import "package:social_media_api/social_media_api.dart" as social_media_api;
import "models/models.dart";
import "package:file_chunked_uploader/file_chunked_uploader.dart" hide UploadDocumentResponse;

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
    final social_media_api.SocialMediaApi _socialMediaApi;

    FileUploaderRepository({
        FileUploaderPermissionsHandler? fileUploaderPermissionsHandler,
        local_file_picker.LocalFilePicker? localFilePicker,
        FileChunkedUploader? fileChunkedUploader,
        required this.globalParams
    })
    :_fileUploaderPermissionsHandler = fileUploaderPermissionsHandler ?? FileUploaderPermissionsHandler(),
     _socialMediaApi = social_media_api.SocialMediaApi(),
     _localFilePicker = localFilePicker ?? local_file_picker.LocalFilePicker(){
        _fileChunkedUploader = fileChunkedUploader??FileChunkedUploader(
            Config(
                baseUrl: globalParams.fileChunkedUploadBaseUrl,
                path: globalParams.fileChunkedUploadPath,
                chunkMaxSize: globalParams.fileChunkedUploadMaxChunkSize,
                contentType: globalParams.fileChunkedUploadContentType,
                authorizationToken:globalParams.fileChunkedUploadAuthorizationToken
            )
        );
     }

     UploadDocumentResponse? _uploadDocumentResponse;

    UploadDocumentResponse? getUploadDocumentResponse(){
        return _uploadDocumentResponse;
    }

    setUploadDocumentResponse(UploadDocumentResponse response){
        _uploadDocumentResponse = response;
        return this;
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

    Future<LocalFile> getFileFromSource(UploadSourceType source,MediaType type,{List<String>? supportedExtensions,double? minSize,double? maxSize}) async{
        local_file_picker.LocalFile file = await _localFilePicker.pickFile(
            source.toLocalFileSource(),
            type.toLocalFileType(),
            supportedExtensions: supportedExtensions,
            minSize:minSize,
            maxSize:maxSize
        );
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
        setUploadDocumentResponse(UploadDocumentResponse.create(_fileChunkedUploader.uploadResult));
    }

    Future<Constrains> getConstrains() async {
        final ds = await _socialMediaApi.getConstraints();
        if(ds is social_media_api.DataFailed || ds.data?.isValid()==false) return Constrains().setErrorMessage("Can't get configuration from server ,please try again later !");
        return Constrains().setConstrainsFromApi(ds.data!);
    }

}
import "dart:io";
import "package:file_uploader_permissions_handler/file_uploader_permissions_handler.dart" hide PermissionsState ;
import "package:flutter/foundation.dart";
import "package:local_file_picker/local_file_picker.dart" as local_file_picker;
import "package:social_media_api/social_media_api.dart" as sma;
import "models/models.dart";
import "package:file_chunked_uploader/file_chunked_uploader.dart" as fcu;

/*
Messages :
- permissions granted successfully
- unable to load files from device
- please give us access to the permissions below :
- file type not supported
- user cancel operation
- file picked successfully
*/

class FileUploaderRepository<Response extends fcu.UploadResponse>{
    final FileUploaderPermissionsHandler _fileUploaderPermissionsHandler;
    final local_file_picker.LocalFilePicker _localFilePicker;
    late fcu.FileChunkedUploader _fileChunkedUploader;
    final GlobalParams globalParams;
    final sma.SocialMediaApi _socialMediaApi;

    static FileUploaderRepository<Response> create<Response extends fcu.UploadResponse>(
        {required GlobalParams globalParams,
            required Response Function(Map<String, dynamic> json, {String? token}) fromJson}) {
        return FileUploaderRepository<Response>._(
            globalParams: globalParams,
            fromJson: fromJson,
        );
    }

    FileUploaderRepository._({
        FileUploaderPermissionsHandler? fileUploaderPermissionsHandler,
        local_file_picker.LocalFilePicker? localFilePicker,
        fcu.FileChunkedUploader? fileChunkedUploader,
        required this.globalParams,
        required Response Function(Map<String, dynamic> json, {String? token}) fromJson,
    })
    :_fileUploaderPermissionsHandler = fileUploaderPermissionsHandler ?? FileUploaderPermissionsHandler(),
     _socialMediaApi = sma.SocialMediaApi(),
     _localFilePicker = localFilePicker ?? local_file_picker.LocalFilePicker(){
        _fileChunkedUploader = fileChunkedUploader??fcu.FileChunkedUploader<Response>(
            fcu.Config(
                baseUrl: globalParams.baseUrl,
                path: globalParams.fileChunkedUploadPath,
                chunkMaxSize: globalParams.fileChunkedUploadMaxChunkSize,
                contentType: globalParams.fileChunkedUploadContentType,
                authorizationToken:globalParams.authorizationToken
            ),
            fromJson
        );
     }

     UploadDocumentResponse? _uploadDocumentResponse;
     UploadDocumentResponseForNetwork? _uploadDocumentResponseForNetwork;

    UploadDocumentResponse? getUploadDocumentResponse(){
        return _uploadDocumentResponse;
    }

    UploadDocumentResponseForNetwork? getUploadDocumentResponseForNetwork(){
        return _uploadDocumentResponseForNetwork;
    }


    setUploadDocumentResponse(UploadDocumentResponse response){
        _uploadDocumentResponse = response;
        return this;
    }

    setUploadDocumentResponseForNetwork(UploadDocumentResponseForNetwork response){
        _uploadDocumentResponseForNetwork = response;
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
            throw Exception("Server unavailable");
        });
        setUploadDocumentResponse(UploadDocumentResponse.create(_fileChunkedUploader.uploadResult as fcu.UploadDocumentResponse?));
    }

    Stream<int> uploadFileToServerForNetwork(File file,{String? publicationId,String? accountId}) async* {
        yield* _fileChunkedUploader.upload(file,data:{"publication":publicationId,"account_id":accountId}).handleError((error){
            throw Exception("Server unavailable");
        });
        setUploadDocumentResponseForNetwork(UploadDocumentResponseForNetwork.create(_fileChunkedUploader.uploadResult as fcu.UploadDocumentResponseForNetwork?));
    }

    Future<Constrains> getConstrains() async {
        final ds = await _socialMediaApi.getConstraints();
        if(ds is sma.DataFailed || ds.data?.isValid()==false) return Constrains().setErrorMessage("Can't get configuration from server ,please try again later !");
        return Constrains().setConstrainsFromApi(ds.data!);
    }

    Future<UpdatePublicationResponse> updateDocument(UpdatePublicationRequest request) async {
        sma.DataState<sma.UpdatePublicationResponse> ds = await _socialMediaApi.updateDocument(publicationId: request.publicationId,title: request.title,description: request.description,datedAt: request.datedAt);
        if(ds is sma.DataFailed) {
            return UpdatePublicationResponse.failed(errors: [ds.error!]);
        } else if(ds.data!.hasErrors()) {
            return UpdatePublicationResponse.failed(errors: ds.data!.getErrors());
        }else{
            return UpdatePublicationResponse.success(data: ds.data);
        }
    }


}
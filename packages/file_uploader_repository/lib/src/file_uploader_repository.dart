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
    late fcu.FileChunkedUploader fileChunkedUploader;
    final sma.SocialMediaApi _socialMediaApi;

    static FileUploaderRepository<Response> create<Response extends fcu.UploadResponse>(
        {
            //required GlobalParams globalParams,
            //required Response Function(Map<String, dynamic> json, {String? token}) fromJson,
            required fcu.FileChunkedUploader fileChunkedUploader
        }) {
        return FileUploaderRepository<Response>._(
            //fromJson: fromJson,
            fileChunkedUploader: fileChunkedUploader
        );
    }

    FileUploaderRepository._({
        FileUploaderPermissionsHandler? fileUploaderPermissionsHandler,
        local_file_picker.LocalFilePicker? localFilePicker,
        required this.fileChunkedUploader,
        //required Response Function(Map<String, dynamic> json, {String? token}) fromJson,
    })
    :_fileUploaderPermissionsHandler = fileUploaderPermissionsHandler ?? FileUploaderPermissionsHandler(),
     _socialMediaApi = sma.SocialMediaApi(),
     _localFilePicker = localFilePicker ?? local_file_picker.LocalFilePicker(){
        /*_fileChunkedUploader = fileChunkedUploader??fcu.FileChunkedUploader<Response>(
            fcu.Config(
                baseUrl: globalParams.baseUrl,
                path: globalParams.fileChunkedUploadPath,
                chunkMaxSize: globalParams.fileChunkedUploadMaxChunkSize,
                contentType: globalParams.fileChunkedUploadContentType,
                authorizationToken:globalParams.authorizationToken
            ),
            fromJson
        );*/
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
                !result.isPermissionsNeedOpenSettings?"unable to load files from device":"please give us access to required permissions"
            ),
            openSettingDialog: result.isPermissionsNeedOpenSettings,
            permissionsNotRequestedYet: result.permissionsNotRequestedYet
        );
    }

    Future<bool> openSettingsToGrantPermissions()async{
        return await _fileUploaderPermissionsHandler.openSettingsToGrantpermissions();
    }

    Future<LocalFile> getFileFromSource(UploadSourceType source,MediaType type,{List<String>? supportedExtensions,double? minSize,double? maxSize}) async{

        PermissionsState per = await this.requestPermissions();

        if(per.status == PermissionsStatus.denied){
            return LocalFile(
                source: source,
                type: type,
                file: null,
                isAccessDenied: true,
                isOpenSettingsRequired: per.openSettingDialog,
                message: per.message
            );
        }

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
            isError:file.status==local_file_picker.LocalFileStatus.failed ,
            source: file.fileSource.toUploadSourceType(),
            type: file.fileType.toMediaType(),
            file:file.file,
            message:file.message
        );
    }

    Stream<int> uploadFileToServer(File file) async* {
            List<String> _errors = [];
            yield* fileChunkedUploader.upload(file).handleError((error) {
                _errors = _extractErrorsFromResponse(error.response?.data);
            });
        setUploadDocumentResponse(UploadDocumentResponse.create(fileChunkedUploader.uploadResult as fcu.UploadDocumentResponse?)..addErrors(_errors));
    }

    Stream<int> uploadFileToServerForNetwork(File file,{String? publicationId,String? accountId}) async* {
        List<String> _errors = [];
        yield* fileChunkedUploader.upload(file,data:{"publication":publicationId,"account_id":accountId}).handleError((error){
            _errors = _extractErrorsFromResponse(error.response?.data);
        });
        setUploadDocumentResponseForNetwork(UploadDocumentResponseForNetwork.create(fileChunkedUploader.uploadResult as fcu.UploadDocumentResponseForNetwork?)..addErrors(_errors));
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

    List<String> _extractErrorsFromResponse(Map<String, dynamic> response) {
        if (response.containsKey('error')) {
            return [response['error'].toString()];
        }

        if (response.containsKey('errors')) {
            final errors = response['errors'];
            if (errors is Map) {
                return errors.values.map((e) => e.toString()).toList();
            } else if (errors is List) {
                return errors.map((e) => e.toString()).toList();
            }
            return [errors.toString()];
        }

        return [response.toString()];
    }


}
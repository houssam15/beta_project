import "dart:io";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:picture_resizer/picture_resizer.dart" hide ValidConstraints;
import "models/models.dart";
import "package:social_media_api/social_media_api.dart" as social_media_api;
import "package:picture_resizer/picture_resizer.dart" as picture_resizer;
import "package:file_chunked_uploader/file_chunked_uploader.dart" as fcu;
class SocialMediaListFormRepository{
  final PictureResizer pictureResizer;
  final social_media_api.SocialMediaApi socialMediaApi;
  late fcu.FileChunkedUploader _fileChunkedUploader;
  final GlobalParams globalParams;

  SocialMediaListFormRepository({
    PictureResizer? pictureResizer,
    social_media_api.SocialMediaApi? socialMediaApi,
    fcu.FileChunkedUploader? fileChunkedUploader,
    required this.globalParams
  }):
  pictureResizer = pictureResizer??PictureResizer(),
  socialMediaApi = socialMediaApi ?? social_media_api.SocialMediaApi(),
  _fileChunkedUploader = fileChunkedUploader??fcu.FileChunkedUploader<fcu.UploadDocumentResponse>(
      fcu.Config(
      baseUrl: globalParams.baseUrl,
      path: globalParams.fileChunkedUploadPath,
      chunkMaxSize: globalParams.fileChunkedUploadMaxChunkSize,
      contentType: globalParams.fileChunkedUploadContentType,
      authorizationToken:globalParams.authorizationToken
      ),
      (json,{token}) => fcu.UploadDocumentResponse().fromJson(json,token: token)
  );

  List<ValidConstraints>? _validConstraints;
  FileParams? _fileParams;
  BuildContext? _context;

  UploadDocumentForPublicationResponse? _uploadDocumentForPublicationResponse;

  List<ValidConstraints>? get validConstraints => _validConstraints;
  SocialMediaListFormRepository setValidConstraints(List<ValidConstraints>? p){
    _validConstraints = p;
    return this;
  }

  FileParams? get fileParams => _fileParams;
  SocialMediaListFormRepository setFileParams(FileParams? fileParams){
    _fileParams = fileParams;
    return this;
  }

  BuildContext? get context => _context;
  SocialMediaListFormRepository setContext(BuildContext? context){
    _context = context;
    return this;
  }

  setUploadDocumentForPublicationResponse(UploadDocumentForPublicationResponse? result){
    _uploadDocumentForPublicationResponse = result;
  }

  UploadDocumentForPublicationResponse? getUploadDocumentForPublicationResponse(){
    return _uploadDocumentForPublicationResponse;
  }


  Future<ResizedFile> loadFileAndResize() async{
    try{
      if(fileParams==null) throw Exception("Invalid params");

      social_media_api.DataState<social_media_api.UploadedPicture> ds = await socialMediaApi.getUploadedPicture(
        baseUrl: fileParams!.fileRequestOptions.baseUrl,
        method: fileParams!.fileRequestOptions.method,
        bearerToken: fileParams!.fileRequestOptions.token
      );
      if(ds is social_media_api.DataFailed) throw Exception("Can't load file");
      final resizedPicture = await pictureResizer
          .setValidConstraints(validConstraints?.map<picture_resizer.ValidConstraints>(((elm) => elm.toPictureResizerModel())).toList())
          .setContext(context)
          .setFile(ds.data!.file)
          .setExtension(ds.data!.extension.toExtensionString())
          .resizePicture();
      if(resizedPicture == null) throw Exception("Failed to resize file");
      return ResizedFile(resizedPicture);
    }catch(err){
      if(kDebugMode) print(err);
      throw Exception("Can't resize file");
    }
  }

  Future<File> loadFile() async {
    try{
      return File("path");
    }catch(err){
      if(kDebugMode) print(err);
      throw Exception("Can't load file");
    }
  }

  /*Future<UploadedFile> uploadPictureForPublication(File file,{dynamic params}) async {
    UploadedFile uploadedFile = UploadedFile();
    try{
      /*social_media_api.DataState<String> ds = await socialMediaApi.uploadPictureForPublication(file,params:params);
      if(ds is social_media_api.DataFailed) uploadedFile.setError(ds.error!);
      uploadedFile.setPictureUrl(ds.data!);*/
      fcu.
    }catch(err){
      uploadedFile.setError(err.toString());
    }
    return uploadedFile;
  }*/

  Stream<int> uploadFileToServerForPublication(File file,{dynamic params}) async* {
    yield* _fileChunkedUploader.upload(file,data: params).handleError((error){
      if(kDebugMode) print("UploadFileToServer error : $error");
      throw Exception("Server unavailable");
    });
    setUploadDocumentForPublicationResponse(UploadDocumentForPublicationResponse.create(_fileChunkedUploader.uploadResult as fcu.UploadDocumentForPublicationResponse?));
  }

  Future<List<SocialMediaItem>> getSocialMediaList(dynamic data) async {
    //social_media_api.DataState<dynamic> ds = await socialMediaApi.getSocialMediaList();
    //if(ds is social_media_api.DataFailed) throw Exception("Can't get data");
    return SocialMediaItem.fromList(data);
  }

  Future<PublishPublicationResponse> publishPublication(PublishPublicationRequest request) async {
    PublishPublicationResponse response = PublishPublicationResponse();
    try{

    }catch(err){

    }
    return response;
  }

}
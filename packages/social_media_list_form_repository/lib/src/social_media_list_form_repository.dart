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
  _fileChunkedUploader = fileChunkedUploader??fcu.FileChunkedUploader<fcu.UploadDocumentResponseForNetwork>(
      fcu.Config(
      baseUrl: globalParams.baseUrl,
      path: globalParams.fileChunkedUploadPath,
      chunkMaxSize: globalParams.fileChunkedUploadMaxChunkSize,
      contentType: globalParams.fileChunkedUploadContentType,
      authorizationToken:globalParams.authorizationToken
      ),
      (json,{token}) => fcu.UploadDocumentResponseForNetwork().fromJson(json,token: token)
  );

  List<ValidConstraints>? _validConstraints;
  FileParams? _fileParams;
  BuildContext? _context;

  UploadDocumentForPublicationResponseForNetwork? _uploadDocumentForPublicationResponseForNetwork;

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

  setUploadDocumentForPublicationResponseForNetwork(UploadDocumentForPublicationResponseForNetwork? result){
    _uploadDocumentForPublicationResponseForNetwork = result;
  }

  UploadDocumentForPublicationResponseForNetwork? getUploadDocumentForPublicationResponseForNetwork(){
    return _uploadDocumentForPublicationResponseForNetwork;
  }


  Future<social_media_api.UploadedPicture> loadFile() async{
    try{
      if(fileParams==null) throw Exception("Invalid params");
      social_media_api.DataState<social_media_api.UploadedPicture> ds = await socialMediaApi.getUploadedPicture(
        baseUrl: fileParams!.fileRequestOptions.baseUrl,
        method: fileParams!.fileRequestOptions.method,
        bearerToken: fileParams!.fileRequestOptions.token
      );
      if(ds is social_media_api.DataFailed) throw Exception("Can't load file");
      //return file
      return ds.data!;
    }catch(err){
      if(kDebugMode) print(err);
      throw Exception("Can't resize file");
    }
  }

  Future<ResizedFile> resizeFile(social_media_api.UploadedPicture data) async {
    try{
      await pictureResizer
          .setValidConstraints(validConstraints?.map<picture_resizer.ValidConstraints>(((elm) => elm.toPictureResizerModel())).toList())
          .setContext(context)
          .setFile(data.file)
          .setExtension(data.extension.toExtensionString())
          .resizePicture();

      if(pictureResizer.getResizedPicture() == null || pictureResizer.getResizedPicture()?.isValid() != true ) throw Exception("Failed to resize file");
      return ResizedFile(
        file: pictureResizer.getResizedPicture()!.getFile()!,
        //exifData: pictureResizer.getResizedPicture()?.getExifData()
      );
    }catch(err){
      if(kDebugMode) print(err);
      throw Exception("Can't resize file");
    }
  }

  /*Future<File> loadFile() async {
    try{
      return File("path");
    }catch(err){
      if(kDebugMode) print(err);
      throw Exception("Can't load file");
    }
  }*/

  /*Future<UploadedFile> uploadPictureForPublication(File file,{dynamic params}) async {
    UploadedFile uploadedFile = UploadedFile();
    try{
      /*social_media_api.DataState<String> ds = await socialMediaApi.uploadPictureForPublication(file,params:params);
      if(ds is social_media_api.DataFailed) uploadedFile.setError(ds.error!);
      uploadedFile.setPictureUrl(ds.validation!);*/
      fcu.
    }catch(err){
      uploadedFile.setError(err.toString());
    }
    return uploadedFile;
  }*/

  Stream<int> uploadFileToServerForPublication(File file,{dynamic params}) async* {
    List<String> _errors = [];
    yield* _fileChunkedUploader.upload(file,data: params).handleError((error){
      _errors = _extractErrorsFromResponse(error.response?.data);
    });
    setUploadDocumentForPublicationResponseForNetwork(UploadDocumentForPublicationResponseForNetwork.create(_fileChunkedUploader.uploadResult as fcu.UploadDocumentResponseForNetwork?)..addErrors(_errors));
  }


  Future<List<SocialMediaItem>> getSocialMediaList(dynamic data) async {
    //social_media_api.DataState<dynamic> ds = await socialMediaApi.getSocialMediaList();
    //if(ds is social_media_api.DataFailed) throw Exception("Can't get validation");
    return SocialMediaItem.fromList(data);
  }

  Future<PublishPublicationResponse> publishPublication(PublishPublicationRequest request) async {
    PublishPublicationResponse response = PublishPublicationResponse();
    try{

    }catch(err){

    }
    return response;
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
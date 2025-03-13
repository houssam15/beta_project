import "dart:io";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:picture_resizer/picture_resizer.dart" hide ValidConstraints;
import "models/models.dart";
import "package:social_media_api/social_media_api.dart" as social_media_api;

class SocialMediaListFormRepository{
  final PictureResizer pictureResizer;
  final social_media_api.SocialMediaApi socialMediaApi;

  SocialMediaListFormRepository({PictureResizer? pictureResizer,social_media_api.SocialMediaApi? socialMediaApi}):
  pictureResizer = pictureResizer??PictureResizer(),
  socialMediaApi = socialMediaApi ?? social_media_api.SocialMediaApi();


  ValidConstraints? _validConstraints;
  FileParams? _fileParams;
  BuildContext? _context;


  ValidConstraints? get validConstraints => _validConstraints;
  SocialMediaListFormRepository setValidConstraints(ValidConstraints? p){
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

  Future<ResizedFile> loadFileAndResize() async{
    try{
      if(fileParams==null) throw Exception("Invalid params");

      social_media_api.DataState<social_media_api.UploadedPicture> ds = await socialMediaApi.getUploadedPicture(
        baseUrl: fileParams!.fileRequestOptions.baseUrl,
        method: fileParams!.fileRequestOptions.method
      );
      if(ds is social_media_api.DataFailed) throw Exception("Can't load file");
      final resizedPicture = await pictureResizer
          .setValidConstraints(validConstraints?.toPictureResizerModel())
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

  Future<UploadedFile> uploadPictureForPublication(File file,{dynamic params}) async {
    UploadedFile uploadedFile = UploadedFile();
    try{
      social_media_api.DataState<String> ds = await socialMediaApi.uploadPictureForPublication(file,params:params);
      if(ds is social_media_api.DataFailed) uploadedFile.setError(ds.error!);
      uploadedFile.setPictureUrl(ds.data!);
    }catch(err){
      uploadedFile.setError(err.toString());
    }
    return uploadedFile;
  }

  Future<List<SocialMediaItem>> getSocialMediaList() async {
    social_media_api.DataState<dynamic> ds = await socialMediaApi.getSocialMediaList();
    if(ds is social_media_api.DataFailed) throw Exception("Can't get data");
    return SocialMediaItem.fromList(ds.data);
  }

}
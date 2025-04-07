import "package:alpha_flutter_project/common/common.dart";

import 'models/upload_document_response.dart';
import "package:file_uploader_repository/file_uploader_repository.dart" as fur;
import "models/models.dart";
class SocialMediaFileUploaderFormArguments implements FeatureParams<SocialMediaFileUploaderFormArguments>{
  UploadDocumentResponse? uploadDocumentResponse;
  MediaType mediaType;
  dynamic constrains;
  dynamic previousState;
  bool modifySingleDocumentForPublication;
  bool hideSidebar;
  String? publicationId;
  String? accountId;
  SocialMediaFileUploaderFormArguments({
     String? mediaType,
      this.publicationId,
      this.accountId,
     this.modifySingleDocumentForPublication = false,
     fur.UploadDocumentResponse? uploadDocumentResponse,
     this.constrains,
    this.previousState,
    this.hideSidebar = false,
    String? uploadPath
  }):uploadDocumentResponse = uploadDocumentResponse!=null?UploadDocumentResponse.create(uploadDocumentResponse):null,
    mediaType = mediaType == MediaType.picture.toString() ? MediaType.picture:MediaType.video;


  SocialMediaFileUploaderFormArguments create([args]){
    if(args==null){
      return SocialMediaFileUploaderFormArguments();
    }else{
      return args as SocialMediaFileUploaderFormArguments;
    }
  }

  @override
  bool isValid() {
    return true;
  }

}
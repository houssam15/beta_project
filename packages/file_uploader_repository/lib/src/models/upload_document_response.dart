import "package:file_chunked_uploader/file_chunked_uploader.dart" as file_chunked_uploader;
import "upload_document_response_warning.dart";

class UploadDocumentResponse{
  late file_chunked_uploader.UploadDocumentResponse _response;

  UploadDocumentResponse._(this._response);

  // Factory method with default repository
  static UploadDocumentResponse create([file_chunked_uploader.UploadDocumentResponse? repository]) {
    return UploadDocumentResponse._(repository ?? file_chunked_uploader.UploadDocumentResponse());
  }

  bool isValid(){
    return _response.errors.isEmpty;
  }

  List<String>? getErrors(){
    return _response.errors;
  }

  bool isWarningsExist(){
    return _response.isWarningExist();
  }

  bool isNetworksValid(){
    return _response.isNetworksValid();
  }


  bool isFileUploadedSuccessfully(){
    return _response.isFileUploadedSuccessfully();
  }

  List<UploadDocumentResponseWarning> getWarnings(){
    return isWarningsExist() ? UploadDocumentResponseWarning.fromApiForFileUploader(_response.getWarning()):[];
  }

  List<UploadDocumentResponseWarning> getNetworksForListForm(){
    return isNetworksValid() ? UploadDocumentResponseWarning.fromApiForSocialMediaList(_response.getWarning()):[];
  }

  String getPictureUrl(){
    return _response.pictureFormats.first.url;
  }

  String getVideoUrl(){
    return _response.videoFormats.first.url;
  }

  int? getPublicationId(){
    return _response.publicationId;
  }

  List<String> addErrors(List<String> errors){
    _response.addErrors(errors);
    return _response.getErrors();
  }

}
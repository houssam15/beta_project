import "package:file_chunked_uploader/file_chunked_uploader.dart" as file_chunked_uploader;
import "upload_document_response_warning.dart";

class UploadDocumentResponseForNetwork{
  late file_chunked_uploader.UploadDocumentResponseForNetwork _response;

  UploadDocumentResponseForNetwork._(this._response);

  // Factory method with default repository
  static UploadDocumentResponseForNetwork create([file_chunked_uploader.UploadDocumentResponseForNetwork? repository]) {
    return UploadDocumentResponseForNetwork._(repository ?? file_chunked_uploader.UploadDocumentResponseForNetwork());
  }

  bool isValid(){
    return _response.isValid();
  }

  List<String>? getErrorMessages(){
    return _response.getMessages();
  }

  String? getUploadUrl(){
    if(_response.pictureFormats.isNotEmpty){
      return _response.pictureFormats.first.url;
    }else if(_response.videoFormats.isNotEmpty){
      return _response.videoFormats.first.url;
    }else{
      return null;
    }
  }

  List<String> addErrors(List<String> errors){
    _response.addErrors(errors);
    return _response.getErrors();
  }

}
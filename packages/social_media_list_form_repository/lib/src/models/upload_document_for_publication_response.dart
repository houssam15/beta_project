import "package:file_chunked_uploader/file_chunked_uploader.dart" as fcu;

class UploadDocumentForPublicationResponse {
  late fcu.UploadDocumentForPublicationResponse _response;

  UploadDocumentForPublicationResponse._(this._response);

  // Factory method with default repository
  static UploadDocumentForPublicationResponse create([fcu.UploadDocumentForPublicationResponse? repository]) {
    return UploadDocumentForPublicationResponse._(repository ?? fcu.UploadDocumentForPublicationResponse());
  }

  bool isValid(){
    return _response.errors.isEmpty;
  }

  List<String> getErrors(){
    return _response.errors;
  }

  String getUploadUrl(){
    return "";
  }

}
import "package:file_chunked_uploader/file_chunked_uploader.dart" as fcu;

class UploadDocumentForPublicationResponseForNetwork {
  late fcu.UploadDocumentResponseForNetwork _response;

  UploadDocumentForPublicationResponseForNetwork._(this._response);

  // Factory method with default repository
  static UploadDocumentForPublicationResponseForNetwork create([fcu.UploadDocumentResponseForNetwork? repository]) {
    return UploadDocumentForPublicationResponseForNetwork._(repository ?? fcu.UploadDocumentResponseForNetwork());
  }

  bool isValid(){
    return _response.errors.isEmpty &&  _response.violations==null;
  }

  List<String> getErrors() {
    return [
      ..._response.errors,
      if (_response.violations?.messages.isNotEmpty ?? false)
        ..._response.violations!.messages,
    ];
  }

  String getUploadUrl(){
    return "";
  }

  List<String> addErrors(List<String> errors) {
    _response.addErrors(errors);
    return _response.getErrors();
  }

}
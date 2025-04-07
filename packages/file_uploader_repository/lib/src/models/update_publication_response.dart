class UpdatePublicationResponse{
  final dynamic data;
  final List<String> errors;

  UpdatePublicationResponse._({this.data,this.errors = const []});


  static UpdatePublicationResponse success({required dynamic data}) {
    return UpdatePublicationResponse._(data: data);
  }

  static UpdatePublicationResponse failed({required List<String> errors}) {
    return UpdatePublicationResponse._(errors: errors);
  }

  hasErrors(){
    return errors.isNotEmpty;
  }

  List<String> getErrors(){
    return errors;
  }

}
import "../validation/validation.dart";

class UpdatePublicationResponse {
  List<String> errors;

  UpdatePublicationResponse({
     this.errors = const []
  });

  UpdatePublicationResponse setErrors(dynamic data){
      if(data is String){
        errors = [data.toString()];
      }else{
        errors = data.entries.map<String>((e) => "${e.key} : ${e.value}").toList();
      }
      return this;
  }

  List<String> getErrors(){
    return errors;
  }
  bool hasErrors(){
    return errors.isNotEmpty;
  }



  static UpdatePublicationResponse fromJson(dynamic data){
    UpdatePublicationResponse response = UpdatePublicationResponse();
    final validation = UpdatePublicationResponseValidation();
    try{
      if((!validation.validate(data).isValid())){
        ///TODO translation
        response.setErrors(["Invalid data received from server , please contact support !",...validation.getErrors()]);
      }else if(data["error"] != null || data["errors"] != null){
        response.setErrors(data["error"]??data["errors"]);
      }else{
        ///TODO response
      }
    }catch(err){
      response.errors = ["System error !"];
    }
    return response;
  }

}

import "../validators/validators.dart";
class GetQrCodeListResponse{
  GetQrcodeListValidator _validator;
  List<String> _errors;

  GetQrCodeListResponse()
  :_validator = GetQrcodeListValidator()
  ,_errors = [];

  GetQrcodeListValidator getValidator(){
    return _validator;
  }

  List<String> getErrors(){
    return _errors;
  }

}
import "../models/models.dart";
class CommonResponse<T> {
  List<String> errors;
  List<QrcodeItemWithError> invalidItems;

  CommonResponse({this.errors = const [],this.invalidItems = const []});

  List<String> getErrors(){
    return errors;
  }

  T addErrors(String error){
    errors.add(error);
    return this as T;
  }

  T addInvalidItem(QrcodeItemWithError itemError){
    invalidItems.add(itemError);
    return this as T;
  }
}
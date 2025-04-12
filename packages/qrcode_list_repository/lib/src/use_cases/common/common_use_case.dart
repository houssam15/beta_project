import 'package:qrcode_list_api/qrcode_list_api.dart';

class CommonUseCase<T> {
  QrCodeListApi? _api;

  QrCodeListApi getApi(){
    return _api ?? QrCodeListApi();
  }

  T setApi(QrCodeListApi api){
    _api = api;
    return this as T;
  }

}
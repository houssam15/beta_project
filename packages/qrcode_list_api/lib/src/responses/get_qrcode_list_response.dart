import "package:qrcode_list_api/qrcode_list_api.dart";

import "../validators/validators.dart";
import "common_response.dart";
class GetQrCodeListResponse extends CommonResponse<GetQrCodeListResponse>{
  GetQrcodeListValidator _validator;
  List<QrcodeItem> items;
  int totalItems;
  int totalItemByPage;
  String? _token;

  GetQrCodeListResponse({
    this.items = const [],
    List<String>? errors,
    List<QrcodeItemWithError>? invalidItems,
    this.totalItems = 0,
    this.totalItemByPage = 0
  })
  :_validator = GetQrcodeListValidator(),
  super(errors: errors ?? [],invalidItems: invalidItems ?? []);
  
  GetQrcodeListValidator getValidator(){
    return _validator;
  }

  GetQrCodeListResponse setToken(String? token){
    _token = token;
    return this;
  }

  String? getToken(){
    return _token;
  }

  GetQrCodeListResponse fromJson(dynamic data){
    return GetQrCodeListResponse(
      errors: data["error"] != null ? [data["error"]]: data["errors"]?.entries.map<String>((key,value) => value).toList(),
      items: QrcodeItem().setToken(getToken()).setQrCodeResponse(this).toList(data),
      totalItems: data["total_of_items"],
        totalItemByPage: data["number_of_items"]
    );
  }
  
}
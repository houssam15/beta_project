import "package:common/common.dart";
import "package:qrcode_list_api/qrcode_list_api.dart";
import "package:qrcode_list_api/src/responses/responses.dart";
import "package:dio/dio.dart";

class QrCodeListApi extends BaseApi{
  Future<DataState<GetQrCodeListResponse>> getQrcodeList(GetQrCodeListRequest request) async {
    GetQrCodeListResponse _response = GetQrCodeListResponse();
    try{
      Response response = await getApi().get("https://bridge.ewebsolutionskech-dev.com//api/mob/customers/socialnetwork/manager/admin/ListQrCode",options: Options(
          headers: {
            "Authorization":"Bearer 0kaibvma8vdlv3ilpjsflheq86"
          }
      ));
      if (response.statusCode != 200) {
        return DataFailed('Failed to fetch file',details: response);
      }else if(!_response.getValidator().validate(response.data).isValid()){
        return DataFailed('Invalid data received from server',details:_response.getValidator().getErrors());
      }else{
        return DataSuccess(_response);
      }
    }catch(err){
      return DataFailed("Can't get qrcode list",details: err);
    }
  }
}
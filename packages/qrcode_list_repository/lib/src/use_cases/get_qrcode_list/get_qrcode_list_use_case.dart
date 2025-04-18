import "../common/common_use_case.dart";
import "get_qrcode_list_request.dart";
import "get_qrcode_list_response.dart";
import "package:common/common.dart";
import "package:qrcode_list_api/qrcode_list_api.dart" as qrla;
import "../../models/models.dart";
class GetQrCodeListUseCase extends CommonUseCase<GetQrCodeListUseCase>{
  Future<GetQrCodeListResponse> call(GetQrCodeListRequest request) async {
    GetQrCodeListResponse response = GetQrCodeListResponse();
    DataState<qrla.GetQrCodeListResponse> ds = await getApi().getQrcodeList(request.toApiParams());
    if(ds is DataFailed) return response.setErrorMessage(ds.error.toString());
    return response.setItems(QrcodeItem.toList(ds.data!.items))
        .setTotalItems(ds.data!.totalItems)
        .setTotalItemsByPage(ds.data!.totalItemByPage)
        .setInvalidItems(ds.data!.invalidItems);//in case some items are not valid , they will saved in invalidPublications list
  }
}
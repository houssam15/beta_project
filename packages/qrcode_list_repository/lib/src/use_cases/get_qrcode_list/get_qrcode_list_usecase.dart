import "../common/common_use_case.dart";
import "get_qrcode_list_request.dart";
import "get_qrcode_list_response.dart";
import "package:common/common.dart";
class GetQrCodeListUseCase extends CommonUseCase<GetQrCodeListUseCase>{
  Future<GetQrCodeListResponse> call(GetQrCodeListRequest request) async {
    GetQrCodeListResponse response = GetQrCodeListResponse();
    final ds = await getApi().getQrcodeList(request.toApiParams());
    if(ds is DataFailed) return response.setErrorMessage(ds.error.toString());
    return response.setPublications(SocialMediaPublication.toList(ds.data!.publications))
        .setTotalItems(ds.data!.totalItems)
        .setTotalItemsByPage(ds.data!.totalItemByPage)
        .setInvalidItems(ds.data!.getInvalidItems());//in case some items are not valid , they will saved in invalidPublications list
  }
}
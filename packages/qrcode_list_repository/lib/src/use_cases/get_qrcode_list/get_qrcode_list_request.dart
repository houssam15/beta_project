import "../common/common_request.dart";
import "package:qrcode_list_api/qrcode_list_api.dart" as qrla;
class GetQrCodeListRequest extends CommonRepositoryRequest<qrla.GetQrCodeListRequest>{

  @override
  qrla.GetQrCodeListRequest toApiParams() {
    return qrla.GetQrCodeListRequest();
  }

}
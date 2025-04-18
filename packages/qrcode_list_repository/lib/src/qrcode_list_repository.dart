import "package:qrcode_list_api/qrcode_list_api.dart" as qrla;
import "use_cases/get_qrcode_list/get_qrcode_list_request.dart";
import "use_cases/get_qrcode_list/get_qrcode_list_response.dart";
import "use_cases/get_qrcode_list/get_qrcode_list_use_case.dart";

class QrCodeListRepository {
  qrla.QrCodeListApi _api;

  QrCodeListRepository()
      :_api = qrla.QrCodeListApi();


  Future<GetQrCodeListResponse> fetchItems(GetQrCodeListRequest request) async {
    return GetQrCodeListUseCase().setApi(_api).call(request);
  }
}
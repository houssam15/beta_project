import "package:qrcode_list_api/qrcode_list_api.dart" as qrla;

class QrCodeListRepository {
  qrla.QrCodeListApi _api;

  QrCodeListRepository()
      :_api = qrla.QrCodeListApi();

  ///Get publications list
  Future<GetPublicationsResponse> getPublications(GetPublicationsRequest request) async {
    return GetPublicationsUseCase().setApi(_api).call(request);
  }
}
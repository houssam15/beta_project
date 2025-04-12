import "package:qrcode_list_api/qrcode_list_api.dart" as qrla;
class QrcodeItemWithError{
  qrla.QrcodeItem item;
  dynamic error;

  QrcodeItemWithError(this.error,this.item);
}
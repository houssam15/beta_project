import 'package:qrcode_list_repository/src/models/models.dart';

class GetQrCodeListResponse {
  List<QrcodeItem> _items;
  String? _errorMessage;
  List<QrcodeItemWithError> _invalidItems;
  int _totalItems;
  int _totalItemsByPage;

  GetQrCodeListResponse()
      :_items = []
  ,_invalidItems = []
  ,_totalItems = 0
  ,_totalItemsByPage = 0;

  GetQrCodeListResponse setErrorMessage(String err){
    _errorMessage = err;
    return this;
  }

  String? getErrorMessage(){
    return _errorMessage;
  }

  bool isValid(){
    return _errorMessage == null;
  }

  List<QrcodeItem> getPublications(){
    return _items;
  }

  GetQrCodeListResponse setPublications(List<QrcodeItem> items){
    _items = items;
    return this;
  }

  List<QrcodeItemWithError> getInvalidItems(){
    return _invalidItems;
  }

  GetQrCodeListResponse setInvalidItems(List<QrcodeItemWithError> items){
    _invalidItems = items;
    return this;
  }

  GetQrCodeListResponse setTotalItems(int total){
    _totalItems = total;
    return this;
  }

  int getTotalItems(){
    return _totalItems;
  }

  GetQrCodeListResponse setTotalItemsByPage(int total){
    _totalItemsByPage = total;
    return this;
  }

  int getTotalItemsByPage(){
    return _totalItemsByPage;
  }

  int getTotalOfInvalidItems(){
    return _invalidItems.length;
  }
}
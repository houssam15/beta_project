import 'package:qrcode_list_api/src/responses/get_qrcode_list_response.dart';

import '../../responses/common_response.dart';
import "qrcode_item_with_error.dart";
import "link_data/picture_data.dart";
import "link_data/pdf_data.dart";


class QrcodeItem<T extends CommonResponse>{
  String? id;
  String? link;
  String? createdAt;
  PictureData? picture;
  PdfData? pdf;
  String? _token;

  QrcodeItem({
    this.id,
    this.link,
    this.createdAt,
    this.picture,
    this.pdf
  });

  T? _response;

  QrcodeItem setQrCodeResponse(T response){
    _response = response;
    return this;
  }

  QrcodeItem setToken(String? token){
    _token = token;
    return this;
  }

  String? getToken(){
    return _token;
  }

  List<QrcodeItem> toList(dynamic data){
      List<QrcodeItem> items = [];
      for(dynamic item in data["items"]){
        QrcodeItem? elm = this.fromJson(item);
        if(elm!=null) items.add(elm);
      }
      return items;
  }

  QrcodeItem? fromJson(dynamic data){
    try{
      return QrcodeItem(
        id: data["id"],
        link: data["link"],
        createdAt: data["created_at"],
        picture: PictureData.fromJson(data["picture"],token: this.getToken()),
        pdf: PdfData.fromJson(data["pdf"],token: this.getToken()),
      );
    }catch(err){
      _response?.addInvalidItem(QrcodeItemWithError(data,err));
      return null;
    }
  }
}
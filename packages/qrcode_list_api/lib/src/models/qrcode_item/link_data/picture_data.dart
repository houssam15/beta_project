import "common/link_data.dart";
import "package:creacom_common/creacom_common.dart";

class PictureData extends LinkData<PictureData>{
  PictureData({String? url}) : super(url: url);

  factory PictureData.fromJson(Map<String, dynamic> data, {String? token}) {
    return PictureData(url: UrlUtils.addQueryParamsToUrl(data["url"],{"token":token}))..setToken(token);
  }
}
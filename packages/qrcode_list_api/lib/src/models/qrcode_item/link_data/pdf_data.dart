import "common/link_data.dart";
import "package:creacom_common/creacom_common.dart";

class PdfData extends LinkData<PdfData>{
  PdfData({String? url}) : super(url: url);

  factory PdfData.fromJson(Map<String, dynamic> data, {String? token}) {
    return PdfData(url: UrlUtils.addQueryParamsToUrl(data["url"],{"token":token}))..setToken(token);
  }
}
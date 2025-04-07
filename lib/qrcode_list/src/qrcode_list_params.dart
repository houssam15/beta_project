import "../../common/common.dart";
class QrcodeListParams implements FeatureParams<QrcodeListParams>{

  @override
  QrcodeListParams create([params]) {
    if (params == null) {
      return QrcodeListParams();
    } else {
      return params as QrcodeListParams;
    }
  }

  @override
  bool isValid() {
    return true;
  }

}
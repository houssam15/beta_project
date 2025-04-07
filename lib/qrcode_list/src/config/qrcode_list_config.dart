import '../../../common/common.dart';

class QrcodeListConfig implements FeatureConfig{
  @override
  String get route => "/qrcode_list";

  @override
  String get langPath => "$featureName/src/lang";

  @override
  String get featureName => "qrcode_list";



}
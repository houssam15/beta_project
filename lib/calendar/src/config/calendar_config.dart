import '../../../common/common.dart';

class CalendarConfig implements FeatureConfig{
  @override
  String get route => "/calendar";

  @override
  String get langPath => "$featureName/src/lang";

  @override
  String get featureName => "calendar";



}
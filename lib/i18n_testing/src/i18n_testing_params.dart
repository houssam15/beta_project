import '../../common/common.dart';

class I18nTestingParams implements FeatureParams{
  @override
  create([params]) {
    return I18nTestingParams();
  }

  @override
  bool isValid() {
    return true;
  }

}
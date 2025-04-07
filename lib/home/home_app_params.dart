
import '../common/common.dart';

class HomeAppParams implements FeatureParams{
  @override
  create([params]) {
    return HomeAppParams();
  }

  @override
  bool isValid() {
    return true;
  }

}
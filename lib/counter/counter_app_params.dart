import '../common/common.dart';

class CounterAppParams implements FeatureParams{
  @override
  create([params]) {
    CounterAppParams();
  }

  @override
  bool isValid() {
    return true;
  }

}
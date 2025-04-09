import '../common/common.dart';

class CounterAppParams implements FeatureParams<CounterAppParams>{
  @override
  CounterAppParams create([params]) {
    return CounterAppParams();
  }

  @override
  bool isValid() {
    return true;
  }

}
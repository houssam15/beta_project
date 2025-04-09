import 'package:alpha_flutter_project/common/common.dart';

class WeatherAppParams implements FeatureParams<WeatherAppParams>{
  @override
  WeatherAppParams create([params]) {
    return WeatherAppParams();
  }

  @override
  bool isValid() {
    return true;
  }

}
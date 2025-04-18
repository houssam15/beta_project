import "../../common/common.dart";
class CalendarParams implements FeatureParams<CalendarParams>{

  @override
  CalendarParams create([params]) {
    if (params == null) {
      return CalendarParams();
    } else {
      return params as CalendarParams;
    }
  }

  @override
  bool isValid() {
    return true;
  }

}
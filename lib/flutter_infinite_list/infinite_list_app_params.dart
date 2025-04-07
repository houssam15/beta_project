import 'package:alpha_flutter_project/common/common.dart';

class InfiniteListAppParams implements FeatureParams<InfiniteListAppParams>{
  @override
  InfiniteListAppParams create([params]) {
    return InfiniteListAppParams();
  }

  @override
  bool isValid() {
    return true;
  }

}
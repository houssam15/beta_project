import "package:alpha_flutter_project/common/common.dart";
import "package:flutter/material.dart";
import "i18n_testing_params.dart";
import "models/models.dart";
import "view/i18n_testing_view.dart";
import "package:localization_service/localization_service.dart";
class I18nTesting extends StatefulWidget {
  static String route = Config.appRoute;
  const I18nTesting({super.key});

  @override
  State<I18nTesting> createState() => _I18nTestingState();
}

class _I18nTestingState extends State<I18nTesting> {
  @override
  Widget build(BuildContext context) {

    return FeatureLayout<I18nTestingParams>(
        child: I18nTestingView(),
        lang: LangParams("i18n_testing/src/lang"),
        params: I18nTestingParams(),
        selectedRoute: Config.appRoute
    );
  }
}

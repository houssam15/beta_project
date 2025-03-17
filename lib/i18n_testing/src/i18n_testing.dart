import "package:flutter/material.dart";
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
    return MaterialApp(
      localeResolutionCallback: LocalizationService.localeResolutionCallback,
      supportedLocales: LocalizationService.supportedLocales,
      localizationsDelegates: LocalizationService(Localizations.localeOf(context),feature: "i18n_testing/src/lang").localizationsDelegate,
      home: I18nTestingView()
    );
  }
}

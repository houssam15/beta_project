import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

class I18nTestingView extends StatefulWidget {
  const I18nTestingView({super.key});

  @override
  State<I18nTestingView> createState() => _I18nTestingViewState();
}

class _I18nTestingViewState extends State<I18nTestingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(context.tr("publish in")),
      ),
    );
  }
}

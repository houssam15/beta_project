import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/common/src/layouts/home_layout.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";
import 'package:provider/single_child_widget.dart';
import "../params/params.dart";
import "../widgets/widgets.dart";

class LangParams {
  LangParams(this.langPath);

  final String langPath;
  LocalizationService? _localizationService;

  LocalizationService getLocalizationService(BuildContext context){
    if(_localizationService==null){
      _localizationService = LocalizationService(Localizations.localeOf(context),feature: langPath);
    }
    return _localizationService!;
  }

}

class ThemeParams {
  final ThemeData? themeData;
  ThemeParams(this.themeData);

  bool isTheme(){
    return themeData != null;
  }
}

class FeatureLayout<P extends FeatureParams> extends StatelessWidget {
  FeatureLayout({
    required this.params,
    this.lang,
    required this.selectedRoute,
    required this.child,
    this.theme,
    this.hideAppbar = true,
    this.providers = const [],
    this.errorWidget,
    this.appBarTitle=""
  });
  final P params;
  final Widget child;
  final LangParams? lang;
  final String selectedRoute;
  final ThemeParams? theme;
  final bool hideAppbar;
  final List<SingleChildWidget> providers;
  final Widget? errorWidget;
  final String appBarTitle;
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: Localizations.localeOf(context),
      delegates: lang?.getLocalizationService(context).localizationsDelegate ?? LocalizationService.getFallbackDelegates(),
      child: HomeLayout(
        selectedRoute: selectedRoute,
        title: appBarTitle,
        hideAppbar: hideAppbar,
        body: theme != null && theme?.isTheme()==true
            ? Theme(data: theme!.themeData!, child: _buildChild(context))
            :_buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context){
    if(!params.isValid()){
      return errorWidget ?? ErrorMessageWidget(context.tr("Invalid params"));
    }else if(providers.isNotEmpty){
      return MultiBlocProvider(
          providers: providers,
          child: child
      );
    }else{
      return child;
    }
  }
}


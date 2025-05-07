import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_localizations/flutter_localizations.dart";
///https://www.youtube.com/watch?v=pKoe8BbHDq4
class LocalizationService{
  late final Locale locale;
  String? feature;
  String langPath;
  List<Locale> supportedLocales;
  LocalizationService(
      this.locale,
      {
        this.feature,
        this.langPath = "assets/lang",
        List<Locale>? supportedLanguage
      }
  ):supportedLocales = supportedLanguage ?? [
    Locale("en","US"),
    Locale("ar","AR"),
    Locale("fr","FR")
  ];

  Locale getLocal(){
    return locale;
  }

  static Map<String,String> _localizedString = {};

  static LocalizationService? of(BuildContext context){
    //print("9 ${context}");
    return Localizations.of(context, LocalizationService);
  }

  Future<void> loadV1() async {
    try{
      //print("PASS 1");
      String p = "";
      if(feature != null){
        p+="packages/$feature/";
      }
      p+=langPath;
      print("DEBUG (LocalizationService) : loading translations from $p");
      final jsonString = await rootBundle.loadString('$p/${locale.languageCode}.json');
      Map<String,dynamic> jsonMap = jsonDecode(jsonString);
      //print("PASS 3 ${jsonMap}");
      _localizedString = jsonMap.map((key, value) => MapEntry(key, value.toString()));
      print("DEBUG (LocalizationService) : translations $_localizedString");
      //print("PASS 4 ${_localizedString}");
    }catch(err){
      if(kDebugMode) print(err);
    }
  }


  String translate(String key){
    //print("PASS 6 ${key}");
    if (_localizedString.isEmpty) {
      return key;
    }
    //print("PASS 7 ${_localizedString[key]}");
    return _localizedString[key]??key;
  }

  String tr(String? key){
    if (_localizedString.isEmpty) {
      return key.toString();
    }
    return _localizedString[key]??key.toString();
  }

  Locale? localeResolutionCallback(Locale? locale,Iterable<Locale>? supportedLocales){
    if(supportedLocales != null && locale != null){
      return supportedLocales.firstWhere((element) =>
      element.languageCode == locale.languageCode,
      orElse: () => supportedLocales.first
      );
    }
    return null;
  }

  //LocalizationsDelegate<LocalizationService> get _delegate => _LocalizationServiceDelegate(feature,supportedLocales);
  LocalizationsDelegate<LocalizationService> get _delegate => _LocalizationServiceDelegate(this);

   List<LocalizationsDelegate<dynamic>> get localizationsDelegate => [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    _delegate
  ];

  List<LocalizationsDelegate<dynamic>> getLocalizationsDelegate(){
    return localizationsDelegate;
  }

   getFallbackDelegates(){
    return [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ];
  }
}


class _LocalizationServiceDelegate extends LocalizationsDelegate<LocalizationService>{
  //final String? featureName;
  //List<Locale> supportedLocales;
  LocalizationService localizationService;
  //_LocalizationServiceDelegate(this.featureName,this.supportedLocales);
  _LocalizationServiceDelegate(this.localizationService);

  @override
  bool isSupported(Locale locale) {
    //return supportedLocales.contains(locale);
    //print("DEBUG (TranslationService) ${localizationService.supportedLocales}");
    return localizationService.supportedLocales.any((l) => l.languageCode == locale.languageCode);
  }

  @override
  Future<LocalizationService> load(Locale locale) async{
    //LocalizationService service = LocalizationService(locale,feature: featureName);
    await localizationService.loadV1();
    return localizationService;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationService> old) {
    return false;
  }

}

extension Translation on BuildContext{
  String tr(String key){
    print("DEBUG (TranslationService) ${LocalizationService.of(this)}");
    return LocalizationService.of(this)?.translate(key) ?? key;
  }
}

class LocalizationsWidget extends StatefulWidget {
  LocalizationsWidget({required this.context,required this.builder,this.packageName});
  BuildContext context;
  final WidgetBuilder builder;
  final String? packageName;

  @override
  State<LocalizationsWidget> createState() => _LocalizationsWidgetState();
}

class _LocalizationsWidgetState extends State<LocalizationsWidget> {
  LocalizationService get _localizationService => LocalizationService(
      Localizations.localeOf(widget.context),
      feature: widget.packageName
  );

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: _localizationService.getLocal(),
        delegates: _localizationService.getLocalizationsDelegate(),
        child:Builder(builder: widget.builder)
    );
  }
}

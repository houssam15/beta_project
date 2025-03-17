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
  final String feature; // Feature name passed dynamically

  LocalizationService(this.locale,{required this.feature});

  static Map<String,String> _localizedString = {};


  static LocalizationService of(BuildContext context){
    return Localizations.of(context, LocalizationService);
  }

  Future<void> loadV1() async {
    try{
      final jsonString = await rootBundle.loadString('lib/${feature}/${locale.languageCode}.json');
      Map<String,dynamic> jsonMap = jsonDecode(jsonString);
      _localizedString = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }catch(err){
      if(kDebugMode) print(err);
    }
  }

  Future<void> loadV2() async {
    try {
      final file = File('lib/${feature}/${locale.languageCode}.json');
      final jsonString = await file.readAsString();

      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      _localizedString = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    } catch (err) {
      if (kDebugMode) print(err);
    }
  }

  String translate(String key){
    if (_localizedString.isEmpty) {
      return key;
    }
    return _localizedString[key]??key;
  }

  static String? tr(String? key){
    if (_localizedString.isEmpty) {
      return key;
    }
    return _localizedString[key]??key;
  }

  static const supportedLocales = [
    Locale("en","US"),
    Locale("ar","AR"),
    Locale("fr","FR")
  ];

  ///Get local if supported
  static Locale? localeResolutionCallback(Locale? locale,Iterable<Locale>? supportedLocales){
    if(supportedLocales != null && locale != null){
      return supportedLocales.firstWhere((element) =>
      element.languageCode == locale.languageCode,
      orElse: () => supportedLocales.first
      );
    }

    return null;
  }

  LocalizationsDelegate<LocalizationService> get _delegate => _LocalizationServiceDelegate(feature);

   dynamic get localizationsDelegate => [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    _delegate
  ];
}

class _LocalizationServiceDelegate extends LocalizationsDelegate<LocalizationService>{
  final String featureName;
  const _LocalizationServiceDelegate(this.featureName);

  @override
  bool isSupported(Locale locale) {
    return ["en","ar"].contains(locale.languageCode);
  }

  @override
  Future<LocalizationService> load(Locale locale) async{
    LocalizationService service = LocalizationService(locale,feature: featureName);
    await service.loadV1();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationService> old) {
    return false;
  }


}

extension Translation on BuildContext{
  String tr(String key){
    return LocalizationService.of(this).translate(key);
  }
}
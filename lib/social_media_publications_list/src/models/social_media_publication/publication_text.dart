import 'dart:ui';

import 'package:alpha_flutter_project/login/login.dart';
import 'package:localization_service/localization_service.dart';

class PublicationText {
  String fullValue;
  bool isEmpty;
  String label;
  PublicationText({
    required this.fullValue,
    this.isEmpty = false,
    required this.label
  });


  static PublicationText fromRepository(String? data,{required BuildContext context,required String label,TextStyle? textStyle}){
    return PublicationText(
        fullValue: data  ?? (LocalizationService.of(context)?.translate("No $label")).toString(),
        isEmpty: data == null,
        label: label
    );
  }
}
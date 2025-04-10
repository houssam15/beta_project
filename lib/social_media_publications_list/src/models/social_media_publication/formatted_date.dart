import 'dart:ui';

import 'package:alpha_flutter_project/login/login.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:localization_service/localization_service.dart';

class FormattedDate {
  String dateText;
  DateTime dateValue;
  Color dateColor;
  FormattedDate({
    required this.dateText,
    required this.dateValue,
    required this.dateColor
  });

  static FormattedDate fromDateTime(DateTime dateTime,{BuildContext? context}){
    return FormattedDate(
        dateText: DateManipulation.formatDateWithFallback(context:context,date: dateTime),
        dateValue: dateTime,
        dateColor: Colors.grey
    );
  }
}


class DateManipulation{
  static String formatDateWithFallback({
    BuildContext? context,
    required DateTime date,
    String? customFormat,
  }) {
    final locale = _getLocaleWithFallback(context);
    initializeDateFormatting(locale, null);
    try {
      final format = customFormat != null? DateFormat(customFormat, locale): DateFormat.yMd(locale).add_jms();
      return format.format(date);
    } catch (e) {
      return date.toString();
    }
  }

  static String _getLocaleWithFallback(BuildContext? context) {
    try {
      return Localizations.localeOf(context!).toString();
    } catch (e) {
      return 'fr_FR';
    }
  }

  static String timeAgoOrFuture({
    required DateTime date,
    BuildContext? context,
    bool shortForm = false // For abbreviated units (e.g., "min" instead of "minutes")
  }){
    final now = DateTime.now();
    final difference = date.difference(now);
    final absoluteDifference = difference.abs();
    
    if(difference.inSeconds.abs() < 5){
      return LocalizationService.of(context).translate("key");
    }
  }
}
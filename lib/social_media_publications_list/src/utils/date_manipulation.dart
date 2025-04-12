import '../config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:localization_service/localization_service.dart';

class DateManipulation {
  /// Gets human-readable time difference (past/future) with translations
  static String timeAgoOrFuture({
    required DateTime date,
    required BuildContext context,
  }) {
    final now = DateTime.now();
    final difference = date.difference(now);
    final absoluteDifference = difference.abs();

    if (difference.inSeconds.abs() < 5) {
      return getTranslation(context, "Just now");
    }

    if (absoluteDifference.inDays > 365) {
      final years = (absoluteDifference.inDays / 365).floor();
      return difference.isNegative
          ?  "$years ${getTranslation(context,"year")}${years > 1 ? 's' : ''} ${getTranslation(context,"ago")}"
          : getTranslation(context, "${getTranslation(context,"in")} $years ${getTranslation(context,"year")}${years > 1 ? 's' : ''}");
    } else if (absoluteDifference.inDays > 30) {
      final months = (absoluteDifference.inDays / 30).floor();
      return difference.isNegative
          ? "$months ${getTranslation(context,"month")}${months > 1 ? 's' : ''} ${getTranslation(context,"ago")}"
          : "${getTranslation(context,"in")} $months ${getTranslation(context,"month")}${months > 1 ? 's' : ''}";
    } else if (absoluteDifference.inDays > 0) {
      return difference.isNegative
          ?  "${absoluteDifference.inDays} ${getTranslation(context,"day")}${absoluteDifference.inDays > 1 ? 's' : ''} ${getTranslation(context,"ago")}"
          :  "${getTranslation(context,"in")} ${absoluteDifference.inDays} ${getTranslation(context,"day")}${absoluteDifference.inDays > 1 ? 's' : ''}";
    } else if (absoluteDifference.inHours > 0) {
      return difference.isNegative
          ? "${absoluteDifference.inHours} ${getTranslation(context,"hour")}${absoluteDifference.inHours > 1 ? 's' : ''} ${getTranslation(context,"ago")}"
          : "${getTranslation(context,"in")} ${absoluteDifference.inHours} ${getTranslation(context,"hour")}${absoluteDifference.inHours > 1 ? 's' : ''}";
    } else if (absoluteDifference.inMinutes > 0) {
      return difference.isNegative
          ? "${absoluteDifference.inMinutes} ${getTranslation(context,"minute")}${absoluteDifference.inMinutes > 1 ? 's' : ''} ${getTranslation(context,"ago")}"
          : "${getTranslation(context,"in")} ${absoluteDifference.inMinutes} ${getTranslation(context,"minute")}${absoluteDifference.inMinutes > 1 ? 's' : ''}";
    } else {
      return difference.isNegative
          ? "${absoluteDifference.inSeconds} ${getTranslation(context,"second")}${absoluteDifference.inSeconds > 1 ? 's' : ''} ${getTranslation(context,"ago")}"
          : "${getTranslation(context,"in")} ${absoluteDifference.inSeconds} ${getTranslation(context,"second")}${absoluteDifference.inSeconds > 1 ? 's' : ''}";
    }
  }

  /// Gets translation using your LocalizationService
  static String getTranslation(BuildContext context, String key) {
    return LocalizationService(
      Locale(getLocaleWithFallback(context)),
      feature: SocialMediaPublicationsListConfig.featureName,
    ).translate(key);
  }



  /// Gets locale from context with French fallback
  static String getLocaleWithFallback(BuildContext? context) {
    try {
      return Localizations.localeOf(context!).toString();
    } catch (e) {
      return 'fr_FR';
    }
  }

}
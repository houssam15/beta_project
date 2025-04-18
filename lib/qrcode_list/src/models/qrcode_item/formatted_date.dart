import 'dart:ui';
import 'package:flutter/material.dart';
import "../../utils/utils.dart";
class FormattedDate {
  String dateText;
  DateTime dateValue;
  String formattedDate;
  Color dateColor;
  FormattedDate({
    required this.dateText,
    required this.dateValue,
    required this.formattedDate,
    required this.dateColor
  });

  static FormattedDate fromDateTime(DateTime dateTime,{required BuildContext context}){
    return FormattedDate(
        dateText: DateManipulation.timeAgoOrFuture(context:context,date: dateTime),
        dateValue:  dateTime,
        formattedDate: DateManipulation.getLocalFormat(context:context,date: dateTime,showTime: true),
        dateColor: Colors.grey
    );
  }

}


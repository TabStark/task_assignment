import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormat {
  static String getFormattedTime(
      {required BuildContext context, required int time}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);

    String date = DateFormat.yMMMd().format(dateTime);
    return date;
  }
}

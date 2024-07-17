import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickDateTime {
  static Future<dynamic> time(BuildContext context) async {
    TimeOfDay currentTime = TimeOfDay.now();

    final picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (picked != null) {
      return picked;
    }
    return currentTime;
  }

  static Future<dynamic> date(BuildContext context) async {
    DateTime currentDate = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      return pickedDate;
    }
    return currentDate;
  }

  static String dateAndTimeFormat(
      {required String date, required String time}) {
    String inputDateTime = '$date $time';
    DateTime parsedDateTime =
        DateFormat("yyyy-MM-dd hh:mm a").parse(inputDateTime);
    String formattedDateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(parsedDateTime);

    return formattedDateTime;
  }
}

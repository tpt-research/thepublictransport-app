import 'package:flutter/material.dart';

class DateParser {

  static String getRFCDate(DateTime date, TimeOfDay time) {
    return date.year.toString().padLeft(4, '0') +
        "-" +
        date.month.toString().padLeft(2, '0') +
        "-" +
        date.day.toString().padLeft(2, '0') +
        "T" +
        time.hour.toString().padLeft(2, '0') +
        ":" +
        time.minute.toString().padLeft(2, '0') +
        ":" +
        "00";
  }
  static String getPureRFCDate(DateTime date) {
    return date.year.toString().padLeft(4, '0') +
        "-" +
        date.month.toString().padLeft(2, '0') +
        "-" +
        date.day.toString().padLeft(2, '0') +
        "T" +
        date.hour.toString().padLeft(2, '0') +
        ":" +
        date.minute.toString().padLeft(2, '0') +
        ":" +
        "00";
  }

  static String getTPTDate(DateTime date, TimeOfDay time) {
    return date.day.toString().padLeft(2, '0') +
        "." +
        date.month.toString().padLeft(2, '0') +
        "." +
        date.year.toString().padLeft(4, '0') +
        "T" +
        time.hour.toString().padLeft(2, '0') +
        ":" +
        time.minute.toString().padLeft(2, '0') +
        ":" +
        "00";
  }
}
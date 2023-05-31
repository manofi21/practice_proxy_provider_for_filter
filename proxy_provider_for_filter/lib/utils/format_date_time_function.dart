import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatDateTime({
  required DateTime dateTime,
  FormatPattern formatPattern = FormatPattern.full,
  String? pattern,
  Locale? locale,
}) {
  return DateFormat(
    pattern ?? formatPattern.pattern,
    locale?.languageCode,
  ).format(dateTime);
}

String formatDateTimeByCurrentTime({
  required DateTime dateTime,
  Locale? locale,
}) {
  if (today.day == dateTime.day) {
    return DateFormat("kk:mm").format(dateTime);
  }
  return DateFormat(
    "dd MMMM yyyy",
    locale?.languageCode,
  ).format(dateTime);
}

enum FormatPattern {
  full,
  onlyDate,
  onlyTime,
  onlyTimeHm,
  onlyYear,
  dayMonth,
  shortDateTime,
  shortDateTimeHm,
  shortDate,
  shortDateFullYear,
  fullDateTime,
  ddMMyyyy,
  yyyyMMdd,
  salesItem,
  monthMMyyyy,
  dateYearTime,
  ddMMMMyyyy,
  ddMMMyyyyhhmmss,
  ddMMMyyyyhhmmssV2,
  dateWithDay,
  fullDateTimeWithoutSeconds,
  timeAmPm,
  dateComaFullTime,
  loginDateTime,
}

extension FormatPatternExtension on FormatPattern {
  String get pattern {
    if (this == FormatPattern.full) {
      return "kk:mm – dd MMMM yyyy";
    }
    if (this == FormatPattern.onlyDate) {
      return "dd MMMM yyyy";
    }
    if (this == FormatPattern.onlyTime) {
      return "kk:mm";
    }
    if (this == FormatPattern.onlyTimeHm) {
      return "HH:mm";
    }
    if (this == FormatPattern.dayMonth) {
      return "dd MMM";
    }
    if (this == FormatPattern.shortDateTime) {
      return "dd MMM yy - kk:mm";
    }
    if (this == FormatPattern.shortDateTimeHm) {
      return "dd MMM yy - HH:mm";
    }
    if (this == FormatPattern.shortDate) {
      return "dd MMM yy";
    }
    if (this == FormatPattern.shortDateFullYear) {
      return "d MMM yyyy";
    }
    if (this == FormatPattern.fullDateTime) {
      return "dd MMM yy - kk:mm:ss";
    }
    if (this == FormatPattern.ddMMMMyyyy) {
      return "dd MMMM yyyy";
    }
    if (this == FormatPattern.ddMMyyyy) {
      return "dd-MM-yyyy";
    }
    if (this == FormatPattern.yyyyMMdd) {
      return "yyyy-MM-dd";
    }
    if (this == FormatPattern.salesItem) {
      return "dd MMM yy, kk:mm:ss";
    }
    if (this == FormatPattern.monthMMyyyy) {
      return "MM/yyyy";
    }
    if (this == FormatPattern.dateYearTime) {
      return "dd MMM yyyy - hh:mm a";
    }
    if (this == FormatPattern.ddMMMyyyyhhmmss) {
      return "dd MMM yyyy - HH:mm:ss";
    }
    if (this == FormatPattern.ddMMMyyyyhhmmssV2) {
      return "dd MMM yyyy HH:mm:ss";
    }
    if (this == FormatPattern.dateWithDay) {
      return "EEE, dd MMM yyyy";
    }
    if (this == FormatPattern.fullDateTimeWithoutSeconds) {
      return "dd MMM yyyy - HH:mm";
    }
    if (this == FormatPattern.timeAmPm) {
      return "hh:mm a";
    }
    if (this == FormatPattern.dateComaFullTime) {
      return "dd MMM yyyy, HH:mm:ss";
    }
    if (this == FormatPattern.onlyYear) {
      return "yyyy";
    }
    if (this == FormatPattern.loginDateTime) {
      return "dd MMMM yyyy HH:mm";
    }

    return "kk:mm – dd MMMM yyyy";
  }
}

DateTime today = DateTime.now();

DateTime firstDate = DateTime(1);

const String patternTimeStandart = "HH:mm";
const String patternDateStandart = "dd MMM yyyy";
const String patternDateTimeStandart = "dd MMM yyyy - HH:mm";

String formatDateTimeStandart({
  required DateTime dateTime,
  Locale? locale,
  bool onlyTime = false,
  bool onlyDate = false,
}) {
  if (onlyTime) {
    final dateFormat = DateFormat(patternTimeStandart);
    return dateFormat.format(dateTime);
  }

  if (onlyDate) {
    final dateFormat = DateFormat(patternDateStandart);
    return dateFormat.format(dateTime);
  }

  final dateFormat = DateFormat(patternDateTimeStandart);
  return dateFormat.format(dateTime);
}

String formatDateTimeddMMMMyyyy({required DateTime dateTime}) {
  final dateFormat = DateFormat("dd MMMM yyyy");
  return dateFormat.format(dateTime);
}

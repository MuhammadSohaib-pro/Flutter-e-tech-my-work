import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class Utils{
    static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps
              .map((json) => fromJson(json as Map<String, dynamic>))
              .toList();

          sink.add(users);
        },
      );

  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes == 0) {
      return 'Just now';
    } else if (difference.inMinutes < 10) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 12) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 365) {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } else {
      return '';
    }
  }

}

double calculateLateDays(
    String expectedArrivalTime, List<String> actualArrivalTimes) {
  double lateDays = 0;
  DateTime expectedTime = DateFormat("h a").parse(expectedArrivalTime);
  for (int i = 0; i < actualArrivalTimes.length; i++) {
    DateTime actualTime = DateFormat("H:mm").parse(actualArrivalTimes[i]);

    DateTime fullExpectedTime = DateTime(expectedTime.year, expectedTime.month,
        expectedTime.day, expectedTime.hour);

    if (actualTime.isAfter(fullExpectedTime)) {
      Duration difference = actualTime.difference(fullExpectedTime);
      lateDays += difference.inMinutes / (24 * 60); // Convert to decimal days
    }
  }
  return double.parse(lateDays.toStringAsFixed(2));
}


double calculateLateMinutes(
    String expectedArrivalTimes, List<String> actualArrivalTimes) {
  double lateMinutes = 0;
  DateTime expectedTime = DateFormat("h a").parse(expectedArrivalTimes);

  for (int i = 0; i < actualArrivalTimes.length; i++) {
    DateTime actualTime = DateFormat("H:mm").parse(actualArrivalTimes[i]);

    DateTime fullExpectedTime = DateTime(expectedTime.year, expectedTime.month,
        expectedTime.day, expectedTime.hour);

    if (actualTime.isAfter(fullExpectedTime)) {
      Duration difference = actualTime.difference(fullExpectedTime);
      lateMinutes += difference.inMinutes;
    }
  }
  return double.parse(lateMinutes.toStringAsFixed(2));

  
}

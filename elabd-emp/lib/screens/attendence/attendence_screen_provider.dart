import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum TimeType {
  // ignore: constant_identifier_names
  CheckIn,
  // ignore: constant_identifier_names
  CheckOut,
}

class AttendenceScreenProvider with ChangeNotifier {
  int _selectedButton = 1; // Default selected button is 1

  int get selectedButton => _selectedButton;

  void setSelectedButton(int button) {
    _selectedButton = button;
    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>> get checkInOutData {
    final collection = FirebaseFirestore.instance.collection('checkInOut');
    return collection.snapshots().map((snapshot) {
      List<Map<String, dynamic>> data = [];
      for (var doc in snapshot.docs) {
        data.add(doc.data());
      }
      return data;
    });
  }

  List<String> checkInTimes = [];
  Stream<List<Map<String, dynamic>>> fetchTimes(TimeType timeType) {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('checkInOut');
    return collection.snapshots().map((snapshot) {
      List<Map<String, dynamic>> records = [];
      for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
        Map<String, dynamic> data =
            (documentSnapshot.data() as Map<String, dynamic>);
        String timeKey =
            (timeType == TimeType.CheckIn) ? 'checkInTime' : 'checkOutTime';
        String timeValue = data[timeKey];
        String date = data['date'];
        records.add({
          'time': timeValue,
          'date': date,
        });
      }
      return records;
    });
  }
  // Stream<List<Map<String, dynamic>>> fetchCheckInTimes() {
  //   CollectionReference collection =
  //       FirebaseFirestore.instance.collection('checkInOut');
  //   return collection.snapshots().map((snapshot) {
  //     List<Map<String, dynamic>> checkInRecords = [];
  //     for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
  //       Map<String, dynamic> data =
  //           (documentSnapshot.data() as Map<String, dynamic>);
  //       String checkInTime = data['checkInTime'];
  //       String date = data['date'];
  //       checkInRecords.add({
  //         'checkInTime': checkInTime,
  //         'date': date,
  //       });
  //     }
  //     return checkInRecords;
  //   });
  // }

  Stream<List<Map<String, dynamic>>> fetchCheckOutTimes() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('checkInOut');
    return collection.snapshots().map((snapshot) {
      List<Map<String, dynamic>> checkInRecords = [];
      for (QueryDocumentSnapshot documentSnapshot in snapshot.docs) {
        Map<String, dynamic> data =
            (documentSnapshot.data() as Map<String, dynamic>);
        String checkOutTime = data['checkOutTime'];
        String date = data['date'];
        checkInRecords.add({
          'checkOutTime': checkOutTime,
          'date': date,
        });
      }
      return checkInRecords;
    });
  }
}

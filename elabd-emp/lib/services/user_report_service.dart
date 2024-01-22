import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/models/attendance_report_model.dart';
import 'package:elabd_tms_app/models/user_report.dart';
import 'package:elabd_tms_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UserReportService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<UserReport?> getUserReport(String month, int year) async {
    try {
      var data = await _firestore
          .collection('employees')
          .doc(_auth.currentUser!.uid)
          .get();
      UserReport userReport = UserReport.fromMap(data.data()!);
      userReport.attendanceReport =
          await getAttendanceReport(month, year) ?? AttendanceReportModel();
      return userReport;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
    return null;
  }

  Future<AttendanceReportModel?> getAttendanceReport(
      String month, int year) async {
    try {
      DateTime firstDayOfMonth = DateFormat("MMMM").parse(month);
      DateTime lastDayOfMonth =
          DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0);

      int totalDays = lastDayOfMonth.day;
      var attendance = await _firestore
          .collection('checkInOut')
          .where('currentUserId', isEqualTo: _auth.currentUser!.uid)
          .where('currentMY', isEqualTo: '$month $year')
          .get();
      int presents = attendance.docs.length;
      int absents = totalDays - presents;
      List<String> checkInTimes =
          attendance.docs.map((e) => e.get('checkInTime') as String).toList();
      String expectedTime = '9 AM';
      double lateDays = calculateLateDays(expectedTime, checkInTimes);
      double lateMinutes = calculateLateMinutes(expectedTime, checkInTimes);
      return AttendanceReportModel(
          presents: presents,
          absents: absents,
          lateMinutesInDays: lateDays,
          totalLateMinutes: lateMinutes,
          paidLeaves: 2,
          unPaidLeaves: 1);
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
    return null;
  }
}

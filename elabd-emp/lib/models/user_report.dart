import 'package:elabd_tms_app/models/attendance_report_model.dart';

class UserReport {
  final String fullName;
  final String empType;
  final String rooster;
  final String accNo;
  final String bankName;
  final String basicSalary;
  late AttendanceReportModel attendanceReport;
  UserReport(
      {required this.fullName,
      required this.empType,
      required this.rooster,
      required this.accNo,
      required this.bankName,
      required this.basicSalary});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': fullName,
      'empType': empType,
      'rooster': rooster,
      'accNo': accNo,
      'bankName': bankName,
    };
  }

  factory UserReport.fromMap(Map<String, dynamic> map) {
    return UserReport(
      basicSalary: map['salary'] as String,
      fullName: map['name'] as String,
      empType: map['type'] as String,
      // rooster: map['rooster'] as String,
      rooster: map['role'] as String,
      accNo: map['accountNo'] as String,
      bankName: map['bankName'] as String,
    );
  }
}

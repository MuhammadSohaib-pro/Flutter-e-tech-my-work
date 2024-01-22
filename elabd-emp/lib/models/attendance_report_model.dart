class AttendanceReportModel {
  final int presents;
  final int absents;
  final double lateMinutesInDays;
  final double totalLateMinutes;
  final int paidLeaves;
  final int unPaidLeaves;
  AttendanceReportModel({
    this.presents = 0,
    this.absents = 0,
    this.lateMinutesInDays = 0,
    this.totalLateMinutes = 0,
    this.paidLeaves = 0,
    this.unPaidLeaves = 0,
  });
}

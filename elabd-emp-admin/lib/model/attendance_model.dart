class AttendanceModel {
  String? date;
  int? unixTimestamp;
  String? currentUserId;
  String? checkOutTime;
  bool? isLeave;
  String? currentMY;
  String? checkInTime;
  bool? isPresent;
  bool? isAbsent;
  String? name;
  String? image;

  AttendanceModel(
      {this.date,
      this.unixTimestamp,
      this.currentUserId,
      this.checkOutTime,
      this.isLeave,
      this.name,
      this.image,
      this.currentMY,
      this.checkInTime,
      this.isPresent,
      this.isAbsent});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    unixTimestamp = json['unixTimestamp'];
    currentUserId = json['currentUserId'];
    checkOutTime = json['checkOutTime'];
    isLeave = json['isLeave'];
    currentMY = json['currentMY'];
    checkInTime = json['checkInTime'];
    isPresent = json['isPresent'];
    isAbsent = json['isAbsent'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['unixTimestamp'] = unixTimestamp;
    data['currentUserId'] = currentUserId;
    data['checkOutTime'] = checkOutTime;
    data['isLeave'] = isLeave;
    data['currentMY'] = currentMY;
    data['checkInTime'] = checkInTime;
    data['isPresent'] = isPresent;
    data['isAbsent'] = isAbsent;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

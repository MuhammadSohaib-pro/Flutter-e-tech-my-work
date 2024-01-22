class NotificationModel {
  String? image;
  String? receiveToken;
  String? notificationType;
  bool? isRead;
  String? name;
  String? currentDate;
  String? title;
  String? userId;

  NotificationModel({
    this.image,
    this.receiveToken,
    this.notificationType,
    this.isRead,
    this.name,
    this.currentDate,
    this.title,
    this.userId,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    receiveToken = json['receiveToken'];
    notificationType = json['notificationType'];
    isRead = json['isRead'];
    name = json['name'];
    currentDate = json['currentDate'];
    title = json['title'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['receiveToken'] = receiveToken;
    data['notificationType'] = notificationType;
    data['isRead'] = isRead;
    data['name'] = name;
    data['currentDate'] = currentDate;
    data['title'] = title;
    data['userId'] = userId;
    return data;
  }
}

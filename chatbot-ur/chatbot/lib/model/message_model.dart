class MessageModel {
  var message;
  String dateTime;
  bool sentByMe;
  String? id;

  MessageModel(
      {required this.message,
      required this.sentByMe,
      required this.dateTime,
      this.id});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json['message'],
        dateTime: json['dateTime'],
        sentByMe: json['sentByMe'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'sentByMe': sentByMe,
        'dateTime': dateTime,
        'id': id,
      };
}

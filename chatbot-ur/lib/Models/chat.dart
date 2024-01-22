import 'dart:convert';


class Chat {
  String message;
  bool isVoice;
  bool fromUser;
  Chat({
    required this.message,
    required this.isVoice,
    required this.fromUser,
  });

  Chat copyWith({
    String? message,
    bool? isVoice,
    bool? fromUser,
  }) {
    return Chat(
      message: message ?? this.message,
      isVoice: isVoice ?? this.isVoice,
      fromUser: fromUser ?? this.fromUser,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'message': message});
    result.addAll({'isVoice': isVoice});
    result.addAll({'fromUser': fromUser});

    return result;
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      message: map['message'] ?? '',
      isVoice: map['isVoice'] ?? false,
      fromUser: map['fromUser'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() =>
      'Chat(message: $message, isVoice: $isVoice, fromUser: $fromUser)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.message == message &&
        other.isVoice == isVoice &&
        other.fromUser == fromUser;
  }

  @override
  int get hashCode => message.hashCode ^ isVoice.hashCode ^ fromUser.hashCode;
}

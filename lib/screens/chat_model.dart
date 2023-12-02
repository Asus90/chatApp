import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String senredId;
  final String receiverId;
  final String chats;
  final DateTime time;

  ChatModel({
    required this.senredId,
    required this.receiverId,
    required this.chats,
    required this.time,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      senredId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      chats: json['chats'] ?? '',
      time: _parseTime(json['time']),
    );
  }

  static DateTime _parseTime(dynamic time) {
    if (time is String) {
      return DateTime.parse(time);
    } else if (time is Timestamp) {
      return time.toDate();
    } else {
      // Handle other cases or return a default value
      return DateTime.now();
    }
  }
}

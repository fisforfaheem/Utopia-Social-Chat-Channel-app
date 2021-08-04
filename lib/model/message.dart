import 'dart:convert';

class Message {
  String message;
  String server;
  String channel;
  String timestamp;
  String fromEmail;
  Message({
    required this.message,
    required this.server,
    required this.channel,
    required this.timestamp,
    required this.fromEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'server': server,
      'channel': channel,
      'timestamp': timestamp,
      'fromEmail': fromEmail,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      server: map['server'],
      channel: map['channel'],
      timestamp: map['timestamp'],
      fromEmail: map['fromEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}

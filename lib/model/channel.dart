import 'dart:convert';

class Channel {
  String name;
  String server;
  int noOfMember;
  Channel({
    required this.name,
    required this.server,
    required this.noOfMember,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'server': server,
      'noOfMember': noOfMember,
    };
  }

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      name: map['name'],
      server: map['server'],
      noOfMember: map['noOfMember'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Channel.fromJson(String source) =>
      Channel.fromMap(json.decode(source));
}

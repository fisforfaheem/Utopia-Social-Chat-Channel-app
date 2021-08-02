import 'dart:convert';

class Server {
  String name;
  String pic;
  int noOfChannel;
  String createdBy;

  Server({
    required this.name,
    required this.pic,
    required this.noOfChannel,
    required this.createdBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pic': pic,
      'noOfChannel': noOfChannel,
      'createdBy': createdBy,
    };
  }

  factory Server.fromMap(Map<String, dynamic> map) {
    return Server(
      name: map['name'],
      pic: map['pic'],
      noOfChannel: map['noOfChannel'],
      createdBy: map['createdBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Server.fromJson(String source) => Server.fromMap(json.decode(source));
}

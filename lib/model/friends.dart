import 'dart:convert';

class FriendsList {}

class Search {
  String name;
  String pic;
  Search({
    required this.name,
    required this.pic,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pic': pic,
    };
  }

  factory Search.fromMap(Map<String, dynamic> map) {
    return Search(
      name: map['name'],
      pic: map['pic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Search.fromJson(String source) => Search.fromMap(json.decode(source));
}

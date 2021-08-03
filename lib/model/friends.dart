import 'dart:convert';

class FriendsList {}

class Search {
  String name;
  String type;
  Search({
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
    };
  }

  factory Search.fromMap(Map<String, dynamic> map) {
    return Search(
      name: map['name'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Search.fromJson(String source) => Search.fromMap(json.decode(source));
}

import 'dart:convert';

class Users {
  String email;
  String username;
  DateTime dob;
  String gender;
  String password;
  bool isAllowed;
  String pic;

  Users({
    required this.email,
    required this.username,
    required this.dob,
    required this.gender,
    required this.password,
    required this.isAllowed,
    required this.pic,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'dob': dob.toString(),
      'gender': gender,
      'password': password,
      'isAllowed': isAllowed,
      'pic': pic
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      email: map['email'],
      username: map['username'],
      dob: DateTime.parse(map['dob']),
      gender: map['gender'],
      password: map['password'],
      isAllowed: map['isAllowed'],
      pic: map['pic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));
}

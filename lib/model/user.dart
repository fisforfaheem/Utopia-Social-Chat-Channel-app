import 'dart:convert';

class Users {
  String email;
  String username;
  DateTime dob;
  String gender;
  String password;
  bool isAllowed;

  Users({
    required this.email,
    required this.username,
    required this.dob,
    required this.gender,
    required this.password,
    required this.isAllowed,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'dob': dob.toString(),
      'gender': gender,
      'password': password,
      'isAllowed': isAllowed,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      email: map['email'],
      username: map['username'],
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob']),
      gender: map['gender'],
      password: map['password'],
      isAllowed: map['isAllowed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));
}

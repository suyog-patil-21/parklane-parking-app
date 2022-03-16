import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;

  final String? email;
  final String? username;
  final String? mobile;
  static const empty = User(id: "-", email: "-", mobile: "-", username: "-");
  const User(
      {required this.id,
      required this.email,
      required this.username,
      required this.mobile});

  User copyWith({
    String? id,
    String? accessToken,
    String? email,
    String? username,
    String? mobile,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      mobile: mobile ?? this.mobile,
    );
  }

  @override
  List<Object?> get props => [id, email, username, mobile];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      'mobile': mobile,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'],
      username: map['username'],
      mobile: map['mobile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

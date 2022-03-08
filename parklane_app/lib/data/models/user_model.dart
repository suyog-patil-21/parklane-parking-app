import 'dart:convert';

class UserModel {
  // final String name;
  final String _id;
  final String accessToken;
  final String? email;
  // final String password;
  final String? username;
  final String? mobile;

  String get id => _id;

  UserModel(this._id,
      {required this.accessToken, this.email, this.mobile, this.username});

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      // 'accessToken': accessToken,
      'email': email,
      'username': username,
      'mobile': mobile,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['_id'] ?? '',
      accessToken: map['accessToken'] ?? '',
      email: map['email'],
      username: map['username'],
      mobile: map['mobile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? accessToken,
    String? email,
    String? username,
    String? mobile,
  }) {
    return UserModel(
      id ?? _id,
      accessToken: accessToken ?? this.accessToken,
      email: email ?? this.email,
      username: username ?? this.username,
      mobile: mobile ?? this.mobile,
    );
  }
}

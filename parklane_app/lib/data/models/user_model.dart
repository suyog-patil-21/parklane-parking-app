import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String accessToken;
  final String? email;
  final String? username;
  final String? mobile;
  static const empty =
      User(id: "-", accessToken: "-", email: "-", mobile: "-", username: "-");
  const User(
      {required this.id,
      required this.accessToken,
      this.email,
      this.username,
      this.mobile});

  User copyWith({
    String? id,
    String? accessToken,
    String? email,
    String? username,
    String? mobile,
  }) {
    return User(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      email: email ?? this.email,
      username: username ?? this.username,
      mobile: mobile ?? this.mobile,
    );
  }

  @override
  List<Object?> get props => [id, email, username, mobile];
}

import 'dart:math';

import '../models/user_model.dart';
import '../provider/network_service.dart';
import 'auth_repository.dart';

import 'package:equatable/equatable.dart';

class UserRepository {
  NetworkService service = NetworkService();
  User? _user;
  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User("Login_is_this" + Random().nextInt(10).toString()),
    );
  }
}

class User extends Equatable {
  const User(this.id);

  final String id;

  @override
  List<Object> get props => [id];

  static const empty = User('-');
}

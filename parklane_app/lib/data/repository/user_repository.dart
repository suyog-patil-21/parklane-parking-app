import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:parklane_app/data/models/user_model.dart';

import '../provider/network_service.dart';
import 'auth_repository.dart';

class UserRepository {
  NetworkService service = NetworkService();
  User? _user;
  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(
        id: Random().nextInt(10).toString(),
        accessToken: 'token from the web',
      ),
    );
  }
}

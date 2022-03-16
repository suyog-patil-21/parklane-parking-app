import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:parklane_app/constants/globals.dart';
import 'package:parklane_app/data/models/user_model.dart';

import '../provider/network_service.dart';
import 'auth_repository.dart';

class UserRepository {
  NetworkService service = NetworkService();
  User? _user;
  Future<User?> getUser() async {
    if (_user != null) return _user;
    var user = await service.getCurrentUser(Globals.accessToken!);
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User.fromJson(user!),
    );
  }
}

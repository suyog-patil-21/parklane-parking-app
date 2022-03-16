import 'dart:async';
import 'dart:convert';
import 'package:parklane_app/constants/globals.dart';

import '../models/user_model.dart';
import '../provider/network_service.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  NetworkService service = NetworkService();
  final _controller = StreamController<AuthenticationStatus>();
  // ! FIXME  : For login and singnup response is going to be token so try using diffrent Token classs to store the token

  Future<void> login({required String email, required String password}) async {
    var rawData = await service.postLogin(email, password);
    var temp = json.decode(rawData!) as Map<String, dynamic>;
    Globals.accessToken = temp["accessToken"];
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  Future<void> signup(
      {required String username,
      required String email,
      required String password}) async {
    var rawData = await service.postSignUp(username, email, password);
    var temp = json.decode(rawData!) as Map<String, dynamic>;
    Globals.accessToken = temp["accessToken"];
    _controller.add(AuthenticationStatus.authenticated);
  }

  // ? Check the user status using stream
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  void dispose() => _controller.close();

  // * Logout
  void logOut() {
    Globals.accessToken = null;
    _controller.add(AuthenticationStatus.unauthenticated);
  }
}

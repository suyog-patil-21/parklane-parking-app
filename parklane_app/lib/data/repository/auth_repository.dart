import 'dart:async';
import 'dart:convert';

import '../../constants/globals.dart';
import '../provider/network_service.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  NetworkService service = NetworkService();
  final _controller = StreamController<AuthenticationStatus>();
  Future<void> login({required String email, required String password}) async {
    final Map<String, dynamic>? token =
        await service.postLogin(email, password);
    Globals.accessToken = token!["accessToken"];
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  Future<void> signup(
      {required String username,
      required String email,
      required String password}) async {
    final Map<String, dynamic>? token =
        await service.postSignUp(username, email, password);
    Globals.accessToken = token!["accessToken"];
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

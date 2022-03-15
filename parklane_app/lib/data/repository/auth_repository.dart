import 'dart:async';

import '../models/user_model.dart';
import '../provider/network_service.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  NetworkService service = NetworkService();
  final _controller = StreamController<AuthenticationStatus>();
  // ! FIXME  : For login and singnup response is going to be token so try using diffrent Token classs to store the token

  Future<void> login({required String email, required String password}) async {
    // var rawData = await service.postLogin(email, password);
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
    // return UserModel.fromJson(rawData!);
  }

  Future<User> signup(
      {required String username,
      required String email,
      required String password}) async {
    var rawData = await service.postSignUp(username, email, password);
    _controller.add(AuthenticationStatus.authenticated);
    return User(id: "dumep", accessToken: "newconnet");
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
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  // TODO : Confirm signup
}

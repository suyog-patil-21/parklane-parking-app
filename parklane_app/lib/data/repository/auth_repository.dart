import '../models/user_model.dart';
import '../provider/network_service.dart';

class AuthRepository {
  NetworkService service = new NetworkService();
  // FIXME ? : For login and singnup response is going to be token so try using diffrent Token classs to store the token
  Future<UserModel> login(
      {required String email, required String password}) async {
    var rawData = await service.postLogin(email, password);
    return UserModel.fromJson(rawData!);
  }

  Future<UserModel> signup(
      {required String username,
      required String email,
      required String password}) async {
    var rawData = await service.postSignUp(username, email, password);
    return UserModel.fromJson(rawData!);
  }

  // TODO : Logout
  // TODO : Confirm signup
}

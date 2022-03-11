import 'package:parklane_app/data/models/user_model.dart';
import 'package:parklane_app/data/provider/network_service.dart';
import 'package:parklane_app/data/repository/auth_repository.dart';

class UserRepository {
  NetworkService service = NetworkService();
  UserModel? _user;
  Future<UserModel?> getUser() async {
    if (_user != null) return _user;
    try {
      // var user = await service.postLogin(email, password);
      return Future.delayed(const Duration(milliseconds: 300),
          () => _user = UserModel('2342', accessToken: 'accessToken'));
    } catch (er) {
      throw er;
    }
  }
}

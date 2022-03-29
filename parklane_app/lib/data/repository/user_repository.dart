import '../../constants/globals.dart';
import '../models/user_model.dart';

import '../provider/network_service.dart';

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

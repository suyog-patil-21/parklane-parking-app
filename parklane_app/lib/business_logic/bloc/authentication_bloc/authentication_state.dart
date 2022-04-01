part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];

  Map<String, dynamic> toCustomMap() {
    return {'user': user.toMap(), 'accessToken': Globals.accessToken};
  }

  factory AuthenticationState.fromCustomMap(Map<String, dynamic> map) {
    // To Store the AccessToken
    Globals.accessToken = map['accessToken'];
    return AuthenticationState.authenticated(
      User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toCustomMap());

  factory AuthenticationState.fromJson(String source) =>
      AuthenticationState.fromCustomMap(json.decode(source));
}

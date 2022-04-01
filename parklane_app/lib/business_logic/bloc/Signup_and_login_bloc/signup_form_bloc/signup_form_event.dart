part of 'signup_form_bloc.dart';

@immutable
abstract class SignupFormEvent {}

class SignupInitEvent extends SignupFormEvent {}

//  * Signup Events Below
class SignupUsernameChangeEvent extends SignupFormEvent {
  final String username;
  SignupUsernameChangeEvent({required this.username});
}

class SigupEmailChangeEvent extends SignupFormEvent {
  final String email;
  SigupEmailChangeEvent({required this.email});
}

class SignupPasswordChangeEvent extends SignupFormEvent {
  final String password;
  SignupPasswordChangeEvent({required this.password});
}

class SignupSubmitedEvent extends SignupFormEvent {}

class ToggleSignupVisibility extends SignupFormEvent {}

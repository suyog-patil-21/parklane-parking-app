part of 'signup_form_bloc.dart';

class SignupFormState {
  final String username;
  bool get isValidUsername => username.length > 3;
  final String password;
  bool get isValidPassword => password.length > 8;
  final String email;
  bool get isValidEmail => EmailValidator.validate(email.trim());
  final bool isvisible;
  final FormSubmissionStatus formStatus;
  SignupFormState(
      {this.username = '',
      this.password = '',
      this.email = '',
      this.isvisible = true,
      this.formStatus = const InitialFormStatus()});

  SignupFormState copyWith(
      {String? username,
      String? password,
      String? email,
      bool? isvisible,
      FormSubmissionStatus? formStatus}) {
    return SignupFormState(
        username: username ?? this.username,
        password: password ?? this.password,
        email: email ?? this.email,
        isvisible: isvisible ?? this.isvisible,
        formStatus: formStatus ?? this.formStatus);
  }
}

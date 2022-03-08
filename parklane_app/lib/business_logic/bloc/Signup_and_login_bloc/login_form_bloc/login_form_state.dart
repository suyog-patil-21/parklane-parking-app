part of 'login_form_bloc.dart';

class LoginFormState {
  final String password;
  bool get isValidPassword => password.isNotEmpty;
  final String email;
  // ! FIXME : Email Validation not Working
  bool get isValidEmail => EmailValidator.validate(email, true);
  final bool isvisible;
  final FormSubmissionStatus formStatus;
  LoginFormState(
      {this.password = '',
      this.email = '',
      this.isvisible = true,
      this.formStatus = const InitialFormStatus()});

  LoginFormState copyWith(
      {String? username,
      String? password,
      String? email,
      bool? isvisible,
      FormSubmissionStatus? formStatus}) {
    return LoginFormState(
        password: password ?? this.password,
        email: email ?? this.email,
        isvisible: isvisible ?? this.isvisible,
        formStatus: formStatus ?? this.formStatus);
  }
}

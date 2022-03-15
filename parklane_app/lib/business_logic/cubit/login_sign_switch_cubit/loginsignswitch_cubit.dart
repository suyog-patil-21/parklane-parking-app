import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'loginsignswitch_state.dart';

class LoginSignupUISwitchCubit extends Cubit<LoginSignupUISwitchState> {
  LoginSignupUISwitchCubit() : super(LoginUIState());
  void switchToLogin() {
    emit(LoginUIState());
  }

  void switchToSignUp() {
    emit(SignupUIState());
  }
}

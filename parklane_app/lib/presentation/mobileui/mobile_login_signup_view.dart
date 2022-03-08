import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/login_sign_switch_cubit/loginsignswitch_cubit.dart';
import 'mobile_login_view.dart';
import 'mobile_signup_view.dart';

class MobileLoginSignupView extends StatelessWidget {
  static const String route = '/mobileauth';
  const MobileLoginSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginSignupUISwitchCubit, LoginSignupUISwitchState>(
      builder: (context, state) {
        return state is LoginUIState ? MobileLoginView() : MobileSignUpView();
      },
    );
  }
}

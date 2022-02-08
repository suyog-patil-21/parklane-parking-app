import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parklane_app/business_logic/switch_login_signup_bloc/switchloginsignupui_bloc.dart';
import 'package:parklane_app/presentation/mobileui/mobile_login_view.dart';
import 'package:parklane_app/presentation/mobileui/mobile_signup_view.dart';
import 'package:parklane_app/presentation/widgets/custom/ui_design/custom_wave_ui_design.dart';

class MobileLoginSignupView extends StatelessWidget {
  static const String route = '/mobileauth';
  const MobileLoginSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchloginsignupuiBloc, SwitchloginsignupuiState>(
      builder: (context, state) {
        return state is LoginState ? MobileLoginView() : MobileSignUpView();
      },
    );
  }
}

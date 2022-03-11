import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parklane_app/business_logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:parklane_app/data/repository/auth_repository.dart';
import 'package:parklane_app/presentation/screen/home_screen.dart';
import 'package:parklane_app/presentation/screen/login_signup_page.dart';
import 'package:parklane_app/presentation/screen/splash_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
              break;
            case AuthenticationStatus.unauthenticated:
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginSignupScreen.route, (route) => false);
              break;
            default:
              break;
          }
        },
        child: const SplashScreen(),
      ),
    );
  }
}

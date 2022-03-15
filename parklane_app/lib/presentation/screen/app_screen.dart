import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parklane_app/presentation/screen/home_screen.dart';
import '../../business_logic/bloc/authentication_bloc/authentication_bloc.dart';
import '../../data/repository/auth_repository.dart';
import '../router/app_routes.dart';
import 'map_screen.dart';
import 'login_signup_page.dart';

import '../../constants/text_theme.dart';

class AppView extends StatefulWidget {
  AppView({Key? key, required this.appRouter}) : super(key: key);
  // Widget? child;
  final AppRouter appRouter;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Parklane',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        bottomSheetTheme: BottomSheetThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        )))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        )))),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
        cardTheme: CardTheme(
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
        textTheme: textTheme,
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: ((context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushNamedAndRemoveUntil(
                    HomeScreen.route, (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil(
                    LoginSignupScreen.route, (route) => false);
                break;
              default:
                break;
            }
          }),
          child: child,
        );
      },
      // home: App(),
      onGenerateRoute: widget.appRouter.onGenerateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/authentication_bloc/authentication_bloc.dart';
import '../../constants/constant_shape_constrains.dart';
import '../../constants/text_theme.dart';
import '../../data/repository/auth_repository.dart';
import '../router/app_routes.dart';
import 'home_screen.dart';
import 'login_signup_page.dart';
import 'map_screen.dart';

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
        dialogTheme: const DialogTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)))),
        primarySwatch: Colors.amber,
        bottomSheetTheme: BottomSheetThemeData(shape: customShpaeUIElements),
        textButtonTheme:
            TextButtonThemeData(style: ButtonStyle(shape: buttonShape)),
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: ButtonStyle(shape: buttonShape)),
        outlinedButtonTheme:
            OutlinedButtonThemeData(style: ButtonStyle(shape: buttonShape)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
        cardTheme: CardTheme(elevation: 8, shape: customShpaeUIElements),
        textTheme: textTheme,
      ),
      // ! comment builder property below if working on Specific Screen
      // builder: (context, child) {
      //   return BlocListener<AuthenticationBloc, AuthenticationState>(
      //     listener: ((context, state) {
      //       switch (state.status) {
      //         case AuthenticationStatus.authenticated:
      //           _navigator.pushNamedAndRemoveUntil(
      //               HomeScreen.route, (route) => false);
      //           break;
      //         case AuthenticationStatus.unauthenticated:
      //         case AuthenticationStatus.unknown:
      //           _navigator.pushNamedAndRemoveUntil(
      //               LoginSignupScreen.route, (route) => false);
      //           break;
      //         default:
      //           break;
      //       }
      //     }),
      //     child: child,
      //   );
      // },
      home: MapScreen(),
      onGenerateRoute: widget.appRouter.onGenerateRoute,
    );
  }
}

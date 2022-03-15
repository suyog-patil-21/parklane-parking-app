import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:parklane_app/business_logic/bloc/Signup_and_login_bloc/login_form_bloc/login_form_bloc.dart';
import 'package:parklane_app/business_logic/bloc/Signup_and_login_bloc/signup_form_bloc/signup_form_bloc.dart';
import 'package:parklane_app/business_logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:parklane_app/business_logic/cubit/internet_status_cubit/internet_cubit.dart';
import 'package:parklane_app/business_logic/cubit/login_sign_switch_cubit/loginsignswitch_cubit.dart';
import 'package:parklane_app/data/repository/auth_repository.dart';
import 'package:parklane_app/data/repository/user_repository.dart';
import 'package:parklane_app/presentation/router/app_routes.dart';
import 'package:parklane_app/presentation/screen/app_screen.dart';
import 'constants/theme_color.dart' as My;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp(
    authRepository: AuthRepository(),
    userRepository: UserRepository(),
    connectivity: Connectivity(),
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  final AppRouter appRouter;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  const MyApp(
      {Key? key,
      required this.authRepository,
      required this.userRepository,
      required this.connectivity,
      required this.appRouter})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<UserRepository>.value(value: userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider(
            create: (context) => LoginSignupUISwitchCubit(),
          ),
          BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthRepository>(context),
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context))),
          BlocProvider(
            create: (context) => LoginFormBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => SignupFormBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
        ],
        child: AppView(appRouter: appRouter),
        // child: MaterialApp(
        //   title: 'Parklane',
        //   theme: ThemeData(
        //     primarySwatch: Colors.amber,
        //     bottomSheetTheme: BottomSheetThemeData(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(24))),
        //     elevatedButtonTheme: ElevatedButtonThemeData(
        //         style: ButtonStyle(
        //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                 RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12.0),
        //     )))),
        //     outlinedButtonTheme: OutlinedButtonThemeData(
        //         style: ButtonStyle(
        //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                 RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12.0),
        //     )))),
        //     floatingActionButtonTheme: const FloatingActionButtonThemeData(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.all(Radius.circular(12)))),
        //     cardTheme: CardTheme(
        //         elevation: 8,
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(24))),
        //     textTheme: textTheme,
        //   ),
        //   // builder: (context, child) {
        //   //   return App(
        //   //     child: child,
        //   //   );
        //     // return BlocListener<AuthenticationBloc, AuthenticationState>(
        //     //   listener: ((context, state) {
        //     //     switch (state.status) {
        //     //       case AuthenticationStatus.authenticated:
        //     //         Navigator.of(context).pushNamedAndRemoveUntil(
        //     //             HomeScreen.route, (route) => false);
        //     //         break;
        //     //       case AuthenticationStatus.unauthenticated:
        //     //         Navigator.of(context).pushNamedAndRemoveUntil(
        //     //             LoginSignupScreen.route, (route) => false);
        //     //         break;
        //     //       default:
        //     //         break;
        //     //     }
        //     //   }),
        //     //   child: child,
        //     // );
        //   },
        //   // home: App(),
        //   onGenerateRoute: appRouter.onGenerateRoute,

        //   // onGenerateRoute: appRouter.onGenerateRoute,
        //   // initialRoute: LoginSignupScreen.route,
        //   // initialRoute: LoginSignupScreen.route,
        // ),
      ),
    );
  }
}

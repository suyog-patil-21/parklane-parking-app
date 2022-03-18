import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:parklane_app/business_logic/bloc/Signup_and_login_bloc/login_form_bloc/login_form_bloc.dart';
import 'package:parklane_app/business_logic/bloc/Signup_and_login_bloc/signup_form_bloc/signup_form_bloc.dart';
import 'package:parklane_app/business_logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:parklane_app/business_logic/bloc/map/map_bloc.dart';
import 'package:parklane_app/business_logic/cubit/internet_status_cubit/internet_cubit.dart';
import 'package:parklane_app/business_logic/cubit/login_sign_switch_cubit/loginsignswitch_cubit.dart';
import 'package:parklane_app/data/repository/auth_repository.dart';
import 'package:parklane_app/data/repository/user_repository.dart';
import 'package:parklane_app/presentation/router/app_routes.dart';
import 'package:parklane_app/presentation/screen/app_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // For only Portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // For Transparent statusBar
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // For Hydraded Storage
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      authRepository: AuthRepository(),
      userRepository: UserRepository(),
      connectivity: Connectivity(),
      appRouter: AppRouter(),
    )),
    storage: storage,
  );
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
          BlocProvider(
            create: (context) => MapBloc(),
          ),
        ],
        child: AppView(appRouter: appRouter),
      ),
    );
  }
}

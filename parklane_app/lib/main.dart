import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:parklane_app/data/repository/mapbox_repository.dart';
import 'business_logic/cubit/location_marker_cubit/location_marker_cubit.dart';
import 'business_logic/bloc/Signup_and_login_bloc/login_form_bloc/login_form_bloc.dart';
import 'business_logic/bloc/Signup_and_login_bloc/signup_form_bloc/signup_form_bloc.dart';
import 'business_logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'business_logic/cubit/geolocation_cubit/geolocation_cubit.dart';
import 'business_logic/cubit/internet_status_cubit/internet_cubit.dart';
import 'business_logic/cubit/login_sign_switch_cubit/loginsignswitch_cubit.dart';
import 'business_logic/cubit/navigation_cubit/navigation_cubit.dart';
import 'business_logic/utilities/app_bloc_observer.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/geolocation_repository.dart';
import 'data/repository/location_repository.dart';
import 'data/repository/user_repository.dart';
import 'presentation/router/app_routes.dart';
import 'presentation/screen/app_screen.dart';
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
            mapBoxRepository: MapBoxRepository(),
            locationRepository: LocationRepository(),
            geolocationRepository: GeolocationRepository(),
            authRepository: AuthRepository(),
            userRepository: UserRepository(),
            connectivity: Connectivity(),
            appRouter: AppRouter(),
          )),
      storage: storage,
      blocObserver: AppBlocOpebserver());
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  final AppRouter appRouter;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final GeolocationRepository geolocationRepository;
  final LocationRepository locationRepository;
  final MapBoxRepository mapBoxRepository;
  const MyApp(
      {Key? key,
      required this.locationRepository,
      required this.geolocationRepository,
      required this.mapBoxRepository,
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
        RepositoryProvider<GeolocationRepository>.value(
            value: geolocationRepository),
        RepositoryProvider<LocationRepository>.value(value: locationRepository),
        RepositoryProvider<MapBoxRepository>.value(value: mapBoxRepository)
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
            create: (context) => GeolocationCubit(
                geoRepository:
                    RepositoryProvider.of<GeolocationRepository>(context)),
          ),
          BlocProvider(
            create: (context) => LocationMarkerCubit(
                locationRepository:
                    RepositoryProvider.of<LocationRepository>(context)),
          ),
          BlocProvider(
            create: (context) => NavigationCubit(
                mapBoxRepository:
                    RepositoryProvider.of<MapBoxRepository>(context)),
          ),
        ],
        child: AppView(appRouter: appRouter),
      ),
    );
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parklane_app/business_logic/internet_status_cubit/internet_cubit.dart';
import 'package:parklane_app/presentation/screen/login_signup_page.dart';
import 'package:parklane_app/router/app_routes.dart';
import 'constants/theme_color.dart';
import 'presentation/screen/home_screen.dart';
import 'constants/theme_color.dart' as My;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp(
    connectivity: Connectivity(),
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  final AppRouter appRouter;
  MyApp({Key? key, required this.connectivity, required this.appRouter})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit(connectivity: connectivity),
        )
      ],
      child: MaterialApp(
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
          textTheme: TextTheme(
            headline1: GoogleFonts.heebo(
                fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.heebo(
                fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3:
                GoogleFonts.heebo(fontSize: 48, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.heebo(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5:
                GoogleFonts.heebo(fontSize: 24, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.heebo(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.heebo(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.heebo(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.roboto(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.roboto(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          ),
        ),
        home: const HomeScreen(),
        onGenerateRoute: appRouter.onGenerateRoute,
        // initialRoute: LoginSignupScreen.route,
      ),
    );
  }
}

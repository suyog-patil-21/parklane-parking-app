import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parklane_app/business_logic/cubit/internet_status_cubit/internet_cubit.dart';
import 'package:parklane_app/presentation/desktopui/desktop_home_view.dart';
import 'package:parklane_app/presentation/mobileui/mobile_home_view.dart';
import 'package:parklane_app/presentation/widgets/gobals/responsive_layout.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetDisconnected) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  padding: EdgeInsets.all(10),
                  content: Text('Your Are Disconnected'),
                ));
            }
          },
          child: const ResponsiveLayout(
            desktopBody: DesktopHomeView(),
            mobileBody: MobileHomeView(),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/internet_status_cubit/internet_cubit.dart';

import '../desktopui/desktop_home_view.dart';
import '../mobileui/mobile_home_view.dart';

import '../widgets/gobals/responsive_layout.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';
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
        child: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state is InternetConnected) {
              return const ResponsiveLayout(
                desktopBody: DesktopHomeView(),
                mobileBody: MobileHomeView(),
              );
            } else if (state is InternetDisconnected) {
              return Scaffold(
                body: Center(
                    child: Text('You Are Offline',
                        style: Theme.of(context).textTheme.headline4)),
              );
            }
            return const Scaffold(
                body: Center(
                    child:
                        Text('Something when wrong try restarting the app')));
          },
        ),
      ),
    );
  }
}

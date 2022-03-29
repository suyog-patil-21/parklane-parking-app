import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/internet_status_cubit/internet_cubit.dart';
import '../desktopui/desktop_map_view.dart';
import '../mobileui/mobile_map_view.dart';
import '../widgets/gobals/responsive_layout.dart';

class MapScreen extends StatelessWidget {
  static const String route = '/map-screen';
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetDisconnected) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).errorColor,
                  padding: EdgeInsets.all(10),
                  content: Text('You Are Disconnected'),
                ));
            }
          },
          child: ResponsiveLayout(
            desktopBody: DesktopMapView(),
            mobileBody: MobileMapView(),
          )),
    );
  }
}

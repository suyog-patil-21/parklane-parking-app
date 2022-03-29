import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../business_logic/cubit/geolocation_cubit/geolocation_cubit.dart';

import '../widgets/floating_custom_map.dart';
import '../widgets/map_widget.dart';

import '../widgets/bottom_search_bar.dart';

class MobileMapView extends StatelessWidget {
  MobileMapView({Key? key}) : super(key: key);
  final MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    // final appBarHeight = AppBar().preferredSize.height;
    // final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: CustomBottomSearchBar(screenSize: screenSize),
      floatingActionButton: CustomFloatingButton(screenSize: screenSize),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: Stack(
        children: [
          BlocBuilder<GeolocationCubit, GeolocationState>(
            builder: (context, state) {
              return MapWidget(
                screenSize: screenSize,
                mapController: _mapController,
                currentLocation:
                    state is GeolocationLoadedState ? state.position : null,
              );
            },
          ),

          //FLoating list Display
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: BlocBuilder<GeolocationCubit, GeolocationState>(
                        builder: (context, state) {
                          return FloatingActionButton.small(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              print("location button pressed ");
                              if (state is GeolocationDisconnectedState) {
                                BlocProvider.of<GeolocationCubit>(context)
                                    .turnOnLocation();
                              }
                              if (state is GeolocationLoadedState) {
                                _mapController.move(
                                    LatLng(state.position.latitude,
                                        state.position.longitude),
                                    18);
                              }
                            },
                            child: Icon(
                              Icons.my_location_rounded,
                              color: state is GeolocationLoadedState
                                  ? Colors.blue
                                  : null,
                            ),
                          );
                        },
                      )),
                ),
                if (true)
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      // padding: EdgeInsets.zero,
                      height: 140,
                      // color: Colors.yellowAccent,
                      child: Card(
                        margin: const EdgeInsets.all(12.0),
                        // color: Colors.amber,
                        child: Row(children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(12.0),
                                padding: EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('heading',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    Text('subtitle',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    Spacer(),
                                    Row(
                                      children: const [
                                        Icon(Icons.monetization_on_rounded),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text('20/hr'),
                                        Spacer(),
                                        Icon(Icons.car_rental),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text('40'),
                                        Spacer(
                                          flex: 2,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 2,
                            child: Container(
                                padding: EdgeInsets.all(6.0),
                                child: Placeholder(),
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(24.0))),
                          )
                        ]),
                      )),
                CustomBottomSearchBar(screenSize: screenSize)
              ],
            ),
          )
        ],
      ),
    );
  }
}

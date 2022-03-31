import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';

import 'package:latlong2/latlong.dart';
import '../../business_logic/cubit/location_marker_cubit/selected_states.dart';
import '../../data/models/location_model.dart';
import '../../business_logic/cubit/geolocation_cubit/geolocation_cubit.dart';

import '../../business_logic/cubit/location_marker_cubit/location_marker_cubit.dart';
import '../widgets/floating_custom_map.dart';
import '../widgets/map_widget.dart';

import '../widgets/bottom_search_bar.dart';

class MobileMapView extends StatelessWidget {
  MobileMapView({Key? key}) : super(key: key);
  final MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final locationMarkerCubitprovider =
        BlocProvider.of<LocationMarkerCubit>(context);
    locationMarkerCubitprovider.showLocationResult();
    // final appBarHeight = AppBar().preferredSize.height;
    // final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: CustomBottomSearchBar(screenSize: screenSize),
      floatingActionButton: const CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: Stack(
        children: [
          BlocBuilder<LocationMarkerCubit, LocationMarkerState>(
            builder: (context, locationState) {
              return BlocBuilder<GeolocationCubit, GeolocationState>(
                builder: (context, geolocationState) {
                  return MapWidget(
                    parkingLocations:
                        locationState is MarkerListLocationMarkerState
                            ? locationState.locations
                            : [],
                    screenSize: screenSize,
                    mapController: _mapController,
                    currentLocation: geolocationState is GeolocationLoadedState
                        ? geolocationState.position
                        : null,
                  );
                },
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
                BlocBuilder<LocationMarkerCubit, LocationMarkerState>(
                    builder: (context, state) {
                  if (state is MarkerListLocationMarkerState) {
                    return ElevatedButton(
                      onPressed: () {
                        locationMarkerCubitprovider.clearLocaitons();
                      },
                      child: const Text(
                        'Clear All locations',
                      ),
                    );
                  }
                  return Container();
                }),
                BlocBuilder<LocationMarkerCubit, LocationMarkerState>(
                  builder: (context, state) {
                    if (state is MarkerListLocationMarkerState) {
                      final local = state.selectedStatusState;
                      if (local is IsSelected) {
                        return _floatingCardWidget(local, context);
                      }
                    }
                    return Container();
                  },
                ),
                CustomBottomSearchBar(screenSize: screenSize)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _floatingCardWidget(IsSelected local, BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        // padding: EdgeInsets.zero,
        height: 140,
        // color: Colors.yellowAccent,
        child: InkWell(
          onTap: () {},
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
                        Text(local.location.name,
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text(local.location.address.toString(),
                            style: Theme.of(context).textTheme.bodySmall),
                        const Spacer(),
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
          ),
        ));
  }

  void mapMarkerBottomSheet(
      Size screenSize, BuildContext context, LocationModel locaionDetails) {
    Scaffold.of(context).showBottomSheet(
      (context) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              height: screenSize.height * 0.3,
              width: screenSize.width * 0.9,
              // color: Colors.grey,
              child: Card(
                elevation: 0,
                color: Colors.grey.shade300,
                child: Placeholder(color: Theme.of(context).backgroundColor),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              locaionDetails.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              locaionDetails.address.city,
              style: Theme.of(context).textTheme.overline,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Row(
                  children: const [
                    Icon(Icons.car_rental),
                    SizedBox(
                      width: 6,
                    ),
                    Text('12/40'),
                  ],
                ),
                const Spacer(),
                Row(
                  children: const [
                    Icon(Icons.monetization_on_rounded),
                    SizedBox(
                      width: 6,
                    ),
                    Text('20/hr'),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ],
        );
      },
      constraints: BoxConstraints(
          minWidth: screenSize.width, maxHeight: screenSize.height * 0.7),
      // backgroundColor: Colors.lightBlue,
    );
  }
}

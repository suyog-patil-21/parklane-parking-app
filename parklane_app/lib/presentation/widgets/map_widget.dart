import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parklane_app/data/models/directions_model.dart';
import '../../business_logic/cubit/location_marker_cubit/location_marker_cubit.dart';
import '../../data/models/location_model.dart';
import '../../secrets.dart';

class MapWidget extends StatelessWidget {
  MapWidget(
      {Key? key,
      required this.screenSize,
      required this.locations,
      required this.route,
      this.currentLocation,
      this.mapController})
      : super(key: key);
  Position? currentLocation;
  Size screenSize;
  MapController? mapController;
  List<LocationModel> locations;
  List<MapRoute> route;
  final List<Marker> _markers = [];
  final List<LatLng> _polylines = [];
  // @override
  // void initState() {
  //   // setState(() async {
  //   //   await fetchMarkers();
  //   // });
  //   // controller = StreamController<int>.broadcast();
  //   // subscription = controller.stream.listen((event) {
  //   //   print(event);
  //   // });
  //   // controller.sink.addStream(getNumber());
  //   super.initState();
  // }

  // ! FIXME : Rough Implementation of Stream
  // late StreamSubscription<int> subscription;
  // Stream<int> getNumber() async* {
  //   Random ran = Random();
  //   for (int i = 0; i < 100; i++) {
  //     await Future.delayed(const Duration(milliseconds: 2000));
  //     print(i);
  //     yield ran.nextInt(100);
  //   }
  // }

  // late StreamController<int> controller;
  // @override
  // void dispose() {
  //   controller.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // Add the Data that must be done before the rendering in the below funciton.
    onRebuildUpdate(context);
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          center: LatLng(18.5641718, 73.8404533),
          zoom: 15.0,
          minZoom: 12,
          maxZoom: 18.0),
      layers: [
        TileLayerOptions(
          urlTemplate: Secrets.mapBoxCARTOIntegrationURL,
          additionalOptions: {
            "accessToken": Secrets.mapBoxAccessToken,
            "id": 'mapbox.mapbox-streets-v8'
          },
          // attributionBuilder: (_) {
          //   return Text("MapBox");
          // },
        ),
        if (_polylines.isNotEmpty)
          PolylineLayerOptions(
            polylines: [
              Polyline(
                  points: _polylines, strokeWidth: 5.0, color: Colors.green),
            ],
          ),
        MarkerLayerOptions(
          markers: [
            // Current Location Marker
            if (currentLocation != null)
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                    currentLocation!.latitude, currentLocation!.longitude),
                builder: (ctx) => const Icon(
                  Icons.my_location_rounded,
                  color: Colors.blue,
                ),
              ),
            ..._markers,
            // Marker(
            //   width: 80.0,
            //   height: 80.0,
            //   point: LatLng(18.6187067, 73.857895),
            //   builder: (ctx) => GestureDetector(
            //     onTap: () {
            //       // mapMarkerBottomSheet(context);
            //     },
            //     child: const Icon(
            //       Icons.location_on_rounded,
            //       color: Colors.blueGrey,
            //       size: 35,
            //     ),
            //   ),
            // ),
            // Marker(
            //     width: 80.0,
            //     height: 80.0,
            //     point: LatLng(18.6187067, 73.857895),
            //     builder: (ctx) => Container(
            //           color: Colors.blueAccent,
            //           height: 30,
            //           width: 40,
            //           child: Text(state.toString()),
            //         )),
          ],
        ),
      ],
    );
  }

  void onRebuildUpdate(BuildContext context) {
    final markersProvider =
        BlocProvider.of<LocationMarkerCubit>(context, listen: true);
    for (var item in route) {
      for (var cordinate in item.geometry.coordinates) {
        // Data send from server
        // 1 - longitude
        // 0 - latitude
        _polylines.add(LatLng(cordinate[1], cordinate[0]));
      }
    }

    for (var element in locations) {
      _markers.add(Marker(
          point: LatLng(element.locationCode.lat, element.locationCode.long),
          builder: (ctx) => GestureDetector(
                onTap: () {
                  markersProvider.selectLocation(locations, element);
                },
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.orangeAccent,
                  size: 35,
                ),
              )));
    }
  }
}

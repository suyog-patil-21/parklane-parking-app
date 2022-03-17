import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:parklane_app/secrets.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          center: LatLng(51.5, -0.09), zoom: 15.0, minZoom: 12, maxZoom: 18.0),
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
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: const Icon(
                  Icons.my_location_rounded,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

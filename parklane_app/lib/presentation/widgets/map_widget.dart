import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:parklane_app/secrets.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key? key, required this.screenSize}) : super(key: key);
  Size screenSize;
  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
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
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(18.5641718, 73.8404533),
              builder: (ctx) => const Icon(
                Icons.my_location_rounded,
                color: Colors.blue,
              ),
            ),
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(18.6187067, 73.857895),
              builder: (ctx) => GestureDetector(
                onTap: () {
                  MapMarkerBottomSheet(context);
                },
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.blueGrey,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void MapMarkerBottomSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet(
      (context) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              height: widget.screenSize.height * 0.3,
              width: widget.screenSize.width * 0.9,
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
              'Parling Name',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Parling address here',
              style: Theme.of(context).textTheme.overline,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Row(
                  children: [
                    Icon(Icons.car_rental),
                    SizedBox(
                      width: 6,
                    ),
                    Text('40'),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.monetization_on_rounded),
                    SizedBox(
                      width: 6,
                    ),
                    Text('20/hr'),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ],
        );
      },
      constraints: BoxConstraints(
          minWidth: widget.screenSize.width,
          maxHeight: widget.screenSize.height * 0.7),
      // backgroundColor: Colors.lightBlue,
    );
  }
}

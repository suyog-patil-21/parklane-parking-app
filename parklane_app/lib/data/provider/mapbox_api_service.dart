import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:parklane_app/data/provider/custom_error.dart';

import '../../secrets.dart';
import 'package:http/http.dart' as http;

class MapBoxApiService {
  final String baseUrl = "https://api.mapbox.com";
  Future<Map<String, dynamic>> getRoute(
      {required double fromLatitude,
      required double fromLongitude,
      required double toLatitude,
      required double toLongitude}) async {
    // send cordinates in formate <lon>,<lat>;<lon>,<lat>
    Uri uri = Uri.parse(baseUrl +
        "/directions/v5/mapbox/driving-traffic/$fromLongitude,$fromLatitude;$toLongitude,$toLatitude?geometries=geojson&access_token=${Secrets.mapBoxAccessToken}");
    print(uri.query);
    final response = await http.get(
      uri,
    );
    if (response.statusCode < 500) {
      final Map<String, dynamic> payload = json.decode(response.body);
      // ? https://docs.mapbox.com/api/navigation/directions/#directions-api-errors
      switch (payload["code"]) {
        case "Ok":
          return payload;
        case "NoRoute":
        case "NoSegment":
          throw CustomError("Sorry no Path found");
        case "Forbidden":
        case "ProfileNotFound":
        case "InvalidInput":
          throw CustomError("Bad Location Request");
        default:
          throw CustomError("Internal Error");
      }
    } else {
      // Status code greater than 500
      throw CustomError("Please try after some time Server Error");
    }
  }
}

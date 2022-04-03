import 'package:latlong2/latlong.dart';
import 'package:parklane_app/data/models/directions_model.dart';
import 'package:parklane_app/data/provider/mapbox_api_service.dart';

class MapBoxRepository {
  final MapBoxApiService service = MapBoxApiService();

  Future<DirectionRouteModel> getRouteDirections(LatLng to, LatLng from) async {
    final result = await service.getRoute(
        toLongitude: to.longitude,
        toLatitude: to.latitude,
        fromLongitude: from.longitude,
        fromLatitude: from.latitude);
    return DirectionRouteModel.fromMap(result);
  }
}

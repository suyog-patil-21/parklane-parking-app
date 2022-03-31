import '../models/location_model.dart';
import '../provider/network_service.dart';

class LocationRepository {
  NetworkService service = NetworkService();

  Future<List<LocationModel>> getMarkerLocations() async {
    try {
      var locations = await service.getParkingArea();

      List<LocationModel> list = locationModelFromJson(locations!);
      return list;
    } catch (err) {
      print(err);
      return Future.error('Invalid Data in Json');
    }
  }
}

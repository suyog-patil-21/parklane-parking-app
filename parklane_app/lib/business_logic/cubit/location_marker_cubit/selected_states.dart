import 'package:parklane_app/data/models/location_model.dart';

abstract class SelectedState {
  const SelectedState();
}

class IsSelected extends SelectedState {
  final LocationModel location;
  const IsSelected({required this.location});
}

class IsNotSelected extends SelectedState {
  const IsNotSelected();
}

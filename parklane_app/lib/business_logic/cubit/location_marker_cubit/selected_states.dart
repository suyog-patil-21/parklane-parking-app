import '../../../data/models/location_model.dart';

abstract class SelectedState {
  const SelectedState();
}

class IsSelectedState extends SelectedState {
  final LocationModel location;
  const IsSelectedState({required this.location});
}

class IsNotSelectedState extends SelectedState {
  const IsNotSelectedState();
}

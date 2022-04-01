part of 'location_marker_cubit.dart';

abstract class LocationMarkerState extends Equatable {
  const LocationMarkerState();

  @override
  List<Object> get props => [];
}

class EmptyLocationMarkerState extends LocationMarkerState {}

class MarkerListLocationMarkerState extends LocationMarkerState {
  final List<LocationModel> locations;
  final SelectedState selectedStatusState;
  const MarkerListLocationMarkerState(
      {required this.locations,
      this.selectedStatusState = const IsNotSelected()});
  @override
  List<Object> get props => [locations, selectedStatusState];

  MarkerListLocationMarkerState copyWith({
    List<LocationModel>? locations,
    SelectedState? selectedStatusState,
  }) {
    return MarkerListLocationMarkerState(
      locations: locations ?? this.locations,
      selectedStatusState: selectedStatusState ?? this.selectedStatusState,
    );
  }
}

class SingleLocationMarkerState extends LocationMarkerState {}
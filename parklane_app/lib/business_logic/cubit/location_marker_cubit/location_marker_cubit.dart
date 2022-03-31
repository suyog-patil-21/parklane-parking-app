import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parklane_app/business_logic/cubit/location_marker_cubit/selected_states.dart';

import '../../../data/repository/location_repository.dart';

import '../../../data/models/location_model.dart';

part 'location_marker_state.dart';

class LocationMarkerCubit extends Cubit<LocationMarkerState> {
  final LocationRepository _locationRepository;

  LocationMarkerCubit({required LocationRepository locationRepository})
      : _locationRepository = locationRepository,
        super(EmptyLocationMarkerState());
  void selectLocation(
      List<LocationModel> locationlist, LocationModel selected) {
    emit(MarkerListLocationMarkerState(
        locations: locationlist,
        selectedStatusState: IsSelected(location: selected)));
  }

  void clearLocaitons() {
    emit(EmptyLocationMarkerState());
  }

  void showLocationResult() async {
    var locations = await _locationRepository.getMarkerLocations();
    // ! FIXME : emit State here
    emit(MarkerListLocationMarkerState(
      locations: locations,
    ));
  }
}

// class LocationMarkerEvent extends Equatable{
//   const LocationMarkerEvent();
//   @override
//   List<Object?> get props => [];
// }

// class PopulateLocationsEvent extends LocationMarkerEvent {
//   final List<LocationModel> listOfLocation;
//    const PopulateLocationsEvent({
//     required this.listOfLocation,
//   });
// @override
//   List<Object?> get props => [listOfLocation];
// }

// class selecteLocaitonEvent()
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:equatable/equatable.dart';
import 'package:parklane_app/business_logic/cubit/location_marker_cubit/location_marker_cubit.dart';
import 'package:parklane_app/data/models/directions_model.dart';
import 'package:parklane_app/data/repository/geolocation_repository.dart';
import 'package:parklane_app/data/repository/mapbox_repository.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final MapBoxRepository _mapBoxRepository;
  final LocationMarkerCubit _locationMarkerCubit;
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _streamSubscription;
  NavigationCubit(
      {required GeolocationRepository geolocationRepository,
      required MapBoxRepository mapBoxRepository,
      required LocationMarkerCubit locationMarkerCubit})
      : _mapBoxRepository = mapBoxRepository,
        _geolocationRepository = geolocationRepository,
        _locationMarkerCubit = locationMarkerCubit,
        super(NoNavigationState()) {
    _streamSubscription =
        _locationMarkerCubit.stream.listen((locationMarkerStates) {
      if (locationMarkerStates is NavigationLocationMarkerState) {
        final cordinates = locationMarkerStates.destination.locationCode;
        getRouteforMarker(LatLng(cordinates.lat, cordinates.long));
      } else if (locationMarkerStates is EmptyLocationMarkerState ||
          locationMarkerStates is MarkerListLocationMarkerState) {
        emit(NoNavigationState());
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  void getRouteforMarker(LatLng to) async {
    try {
      final currentLocaiton =
          await _geolocationRepository.determineCurrentPosition();
      final route = await _mapBoxRepository.getRouteDirections(
          to, LatLng(currentLocaiton.latitude, currentLocaiton.longitude));
      emit(DirectRouteNavigationState(route));
    } catch (err) {
      emit(NavigationErrorState(errorMessage: err.toString()));
    }
  }
}

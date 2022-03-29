import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/repository/geolocation_repository.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _locationServicesubscription;
  StreamSubscription? _positionSubscription;

  GeolocationCubit({required GeolocationRepository geoRepository})
      : _geolocationRepository = geoRepository,
        super(GeolocationDisconnectedState()) {
    _locationServicesubscription =
        _geolocationRepository.getGeolocationServiceStatus().listen((status) {
      print('inside Geolocation Service : $status');
      if (status == ServiceStatus.enabled) {
        _positionSubscription =
            _geolocationRepository.getCurrentLiveLocation().listen((position) {
          emit(GeolocationLoadedState(position: position));
        }, onError: (err) {
          emit(GeolocationDisconnectedState());
        });
      } else if (status == ServiceStatus.disabled) {
        emit(GeolocationDisconnectedState());
      }
    });
  }

  void turnOnLocation() {
    _geolocationRepository.enableCurrentLocation();
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _locationServicesubscription?.cancel();
    return super.close();
  }
}

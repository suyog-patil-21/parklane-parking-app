part of 'geolocation_cubit.dart';

enum GeoLocationStatus { on, off }

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationConnectedState extends GeolocationState {}

class GeolocationDisconnectedState extends GeolocationState {}

// for gettings the locaitons
class GeolocationLoadingState extends GeolocationState {}

class GeolocationLoadedState extends GeolocationState {
  final Position position;
  GeolocationLoadedState({required this.position});
  @override
  List<Object> get props => [position];

  @override
  String toString() => 'GeolocationLoadedState(position:$position)';
}

class GeolocationErrorState extends GeolocationState {}

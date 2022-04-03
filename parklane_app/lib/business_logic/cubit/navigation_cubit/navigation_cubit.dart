import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:parklane_app/data/models/directions_model.dart';
import 'package:parklane_app/data/repository/mapbox_repository.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final MapBoxRepository _mapBoxRepository;
  NavigationCubit({required MapBoxRepository mapBoxRepository})
      : _mapBoxRepository = mapBoxRepository,
        super(NoNavigationState());

  void getRouteforMarker(LatLng to, LatLng from) async {
    try {
      final route = await _mapBoxRepository.getRouteDirections(to, from);
      emit(DirectRouteNavigationState(route));
    } catch (err) {
      emit(NavigationErrorState(errorMessage: err.toString()));
    }
  }
}

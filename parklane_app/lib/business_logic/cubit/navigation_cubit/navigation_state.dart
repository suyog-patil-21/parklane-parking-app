part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NoNavigationState extends NavigationState {}

class DirectRouteNavigationState extends NavigationState {
  final DirectionRouteModel route;
  const DirectRouteNavigationState(this.route);
}

class NavigationErrorState extends NavigationState {
  final String errorMessage;
  const NavigationErrorState({required this.errorMessage});
}

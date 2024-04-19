part of 'home_bloc.dart';

sealed class HomeEvent {}

class _ScannerEvent extends HomeEvent {
  final List<entity.Device> state;

  _ScannerEvent(
    this.state,
  );
}

class Initialize extends HomeEvent {}

class Foreground extends HomeEvent {}

class Background extends HomeEvent {}

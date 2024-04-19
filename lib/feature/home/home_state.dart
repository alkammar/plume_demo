part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanComplete extends HomeState {}

class Idle extends HomeState {}

class Scanning extends HomeState {}

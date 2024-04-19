import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume_demo/entity/device.dart' as entity;
import 'package:plume_demo/repository/device_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DeviceRepository _deviceRepository;

  HomeBloc({required DeviceRepository deviceRepository})
      : _deviceRepository = deviceRepository,
        super(Idle()) {
    _deviceRepository.stream.listen((devices) {
      add(_ScannerEvent(devices));
    });

    on<Initialize>((event, emit) => _deviceRepository.start());
    on<Foreground>((event, emit) => _deviceRepository.start());
    on<Background>((event, emit) => _deviceRepository.stop());
    on<_ScannerEvent>((event, emit) {
      switch (event.state) {
        case entity.Idle():
          emit(Idle());
        case entity.Scanning():
          emit(Scanning());
        case entity.Scanned():
          emit(ScanComplete());
          _deviceRepository.stop();
      }
    });
  }
}

import 'dart:async';

import 'package:plume_demo/entity/device.dart';
import 'package:plume_demo/repository/device_repository.dart';
import 'package:rxdart/rxdart.dart';

class DeviceDataRepository extends DeviceRepository {
  final StreamController<List<Device>> _controller = BehaviorSubject.seeded([]);

  @override
  Stream<List<Device>> get stream => _controller.stream;

  @override
  stop() {

  }

  @override
  start() {

  }
}

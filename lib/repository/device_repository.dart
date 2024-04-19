import 'package:morkam/repository/repository.dart';
import 'package:plume_demo/entity/device.dart';

abstract class DeviceRepository extends Repository<List<Device>> {
  stop();

  start();
}

import 'package:plume_demo/data_repository/device_data_repository.dart';
import 'package:plume_demo/repository/device_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> repositoryProviders() => [
      Provider<DeviceRepository>(create: (context) => DeviceDataRepository()),
    ];

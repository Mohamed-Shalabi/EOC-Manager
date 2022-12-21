import '../../../core/bluetooth/bluetooth_device_model.dart';
import '../domain/entities/device_entity.dart';
import '../domain/entities/ergonomic_height_entity.dart';
import 'models/ergonomic_height_model.dart';

extension HeightModelToEntity on ErgonomicHeightModel {
  ErgonomicHeightEntity toEntity() {
    return ErgonomicHeightEntity(
      userHeightInCm: userHeightInCm,
      chairHeightInCm: chairHeightInCm,
      monitorHeightInCm: monitorHeightInCm,
    );
  }
}

extension DeviceModelToEntity on BluetoothDeviceModel {
  DeviceEntity toEntity() {
    return DeviceEntity(name: name, id: address);
  }
}

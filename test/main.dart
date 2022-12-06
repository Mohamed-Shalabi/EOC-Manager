import 'package:ergonomic_office_chair_manager/core/bluetooth/bluetooth_connector_interface.dart';
import 'package:ergonomic_office_chair_manager/core/bluetooth/flutter_bluetooth_serial_connector.dart';
import 'package:ergonomic_office_chair_manager/core/functions/string_to_u_int_8_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Testing the sending format',
    () {
      expect([52, 52], '44'.toUInt8List);
    },
  );
}

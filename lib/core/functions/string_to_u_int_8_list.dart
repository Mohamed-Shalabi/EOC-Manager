import 'dart:convert';
import 'dart:typed_data';

extension ToUInt8List on String {
  Uint8List get toUInt8List => Uint8List.fromList(ascii.encode(this));
}

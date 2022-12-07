import 'failure.dart';

class BaseException implements Exception {
  final Failure failure;

  BaseException({required this.failure});
}
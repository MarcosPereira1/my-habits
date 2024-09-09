import 'package:habits/core/exceptions/base_exception.dart';

class UnknownException extends BaseException {
  const UnknownException({
    required super.error,
    required super.stackTrace,
  });
}

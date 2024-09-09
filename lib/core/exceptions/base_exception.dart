import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  const BaseException({
    this.message = '',
    required this.error,
    required this.stackTrace,
  });

  final String message;
  final Object error;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [message, error, stackTrace];
}

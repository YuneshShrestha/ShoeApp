import 'package:equatable/equatable.dart';

class CustomFirebaseException extends Equatable implements Exception {
  final String? message;
  final int? code;

  const CustomFirebaseException({
    this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

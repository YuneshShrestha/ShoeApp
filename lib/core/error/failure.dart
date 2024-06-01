import 'package:equatable/equatable.dart';
import 'package:shoe_shop_app/core/error/exception.dart';

abstract class Failure extends Equatable {
  final String message;
  final int code;

  const Failure(this.message, this.code);
  @override
  List<Object?> get props => [message, code];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message, super.code);
  FirebaseFailure.fromException(CustomFirebaseException e)
      : this(e.message.toString(), e.code as int);
}

import 'package:dartz/dartz.dart';
import 'package:shoe_shop_app/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultFutureVoid = Future<Either<Failure, void>>;
typedef DataMap = Map<String, dynamic>;
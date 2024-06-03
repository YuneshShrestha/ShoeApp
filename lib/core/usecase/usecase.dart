import 'package:shoe_shop_app/core/utils/typedef.dart';

abstract class UseCaseWithParam<T, P> {
  ResultFuture<T> call(P param);
}
abstract class UseCase<T> {
  ResultFuture<T> call();
}
abstract class UseCaseWithTwoParam<T, P1, P2> {
  ResultFuture<T> call(P1 param1, P2 param2);
}
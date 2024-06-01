import 'package:shoe_shop_app/core/utils/typedef.dart';

abstract class UseCaseWithParam<T, P> {
  ResultFuture<T> call(P param);
}
abstract class UseCase<T> {
  ResultFuture<T> call();
}
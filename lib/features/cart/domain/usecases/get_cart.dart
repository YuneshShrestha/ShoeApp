import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/domain/repos/cart_repo.dart';

class GetCart extends UseCase<List<CartItem>> {
  final CartRepo repo;
  GetCart(this.repo);

  @override
  ResultFuture<List<CartItem>> call() async {
    return await repo.getCart();
  }
}

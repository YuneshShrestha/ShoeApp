import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/domain/repos/cart_repo.dart';

class CheckoutCart extends UseCaseWithTwoParam<void, List<CartItem>, double> {
  final CartRepo repo;
  CheckoutCart(this.repo);

  @override
  ResultFutureVoid call(List<CartItem> param1, double param2) async {
    return await repo.checkoutCart(
      param1,
      param2,
    );
  }
}

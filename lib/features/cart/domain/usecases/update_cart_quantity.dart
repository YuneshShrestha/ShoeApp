import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';

import 'package:shoe_shop_app/features/cart/domain/repos/cart_repo.dart';

class UpdateCart extends UseCaseWithTwoParam<void, int, String> {
  final CartRepo repo;
  UpdateCart(this.repo);

  @override
  ResultFutureVoid call(int param1, String param2) async {
    return await repo.updateCartQuantity(
      quantity: param1,
      shoeId: param2,
      
    );
  }
}

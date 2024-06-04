import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/cart/domain/repos/cart_repo.dart';

class DeleteCartItem extends UseCaseWithParam<void, String> {
  final CartRepo repo;
  DeleteCartItem(this.repo);

  @override
  ResultFutureVoid call(String param) async {
    return await repo.deleteCart(
      param,
    );
  }
}

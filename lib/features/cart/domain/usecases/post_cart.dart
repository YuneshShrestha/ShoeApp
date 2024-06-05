import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/domain/repos/cart_repo.dart';

class PostCart extends UseCaseWithParam<void, CartItem> {
  final CartRepo repo;
  PostCart(this.repo);

  @override
  ResultFutureVoid call(CartItem param) async {
    return await repo.postCart(
      shoeId: param.shoeId,
      shoeName: param.shoeName,
      shoeCategory: param.shoeCategory,
      shoeSize: param.shoeSize,
      shoeColor: param.shoeColor,
      quantity: param.quantity,
      shoeImage: param.shoeImage,
      price: param.price,

    );
  }
}

import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';

abstract class CartRepo {
  ResultFuture<List<CartItem>> getCart();
  ResultFutureVoid postCart(
    {
      required String shoeId,
      required String shoeName,
      required String shoeImage,
      required String shoeCategory,
      required int shoeSize,
      required String shoeColor,
      required int quantity,
      required int price,
    }
  );
  ResultFutureVoid updateCartQuantity(
    {

      required int quantity,
      required String shoeId,
    }
  );
  ResultFutureVoid deleteCart(String shoeId);
  ResultFutureVoid checkoutCart(List<CartItem> cartItems, double totalAmount);
}

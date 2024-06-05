import 'package:shoe_shop_app/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartModel>> getCartItems();
  Future<void> postCartItems(CartModel cartItem);
  Future<void> deleteCartItem(String id);
  Future<void> updateCartItem(
      int quantity, String shoeID); //updating the quantity of the cart item
  Future<void> checkoutCart(List<CartModel> cartItems, double totalAmount);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  CartRemoteDataSourceImpl();
  List<CartModel> _cartItems = [];

  @override
  Future<void> checkoutCart(
      List<CartModel> cartItems, double totalAmount) async {
    _cartItems = cartItems;
  }

  @override
  Future<void> deleteCartItem(String id) async {
    _cartItems.removeWhere((element) => element.shoeId == id);
  }

  @override
  Future<List<CartModel>> getCartItems() async {
    final List<CartModel> cartItems =
        List.from(_cartItems); // Create a copy of _cartItems
    return cartItems;
  }

  @override
  Future<void> postCartItems(CartModel cartItem) async {
    _cartItems.add(cartItem);
  }

  @override
  Future<void> updateCartItem(int quantity, String productID) async {
    int index = _cartItems.indexWhere((element) => element.shoeId == productID);
    if (index != -1) {
      CartModel updatedCartItem =
          _cartItems[index].copywith(quantity: quantity);
      _cartItems[index] = updatedCartItem;
    }
  }
}

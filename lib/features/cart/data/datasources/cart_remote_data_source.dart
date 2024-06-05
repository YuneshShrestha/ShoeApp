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
  // @override
  // Future<List<ShoeModel>> getShoes() async {
  //   try {
  //     final data = await API.dio.get(
  //       productEndpoint,
  //     );
  //     if (data.statusCode != 200 && data.statusCode != 201) {
  //       throw CustomFirebaseException(
  //         message: 'Failed to fetch data',
  //         code: data.statusCode,
  //       );
  //     }
  //     Map<String, dynamic> dataMap = {};
  //     List<ShoeModel> shoes = [];

  //     if (data.data['products'] is Map<String, dynamic>) {
  //       dataMap.forEach((key, value) {
  //         shoes.add(ShoeModel.fromMap(value));
  //       });
  //       return shoes;
  //     } else  {
  //     shoes=  (data.data['products'] as List).map<ShoeModel>(
  //         (shoe) {
  //         return ShoeModel.fromMap(shoe);
  //         },
  //       ).toList();
  //       return shoes;
  //     }
  //   } catch (e) {
  //     throw CustomFirebaseException(
  //       message: e.toString(),
  //       code: 500,
  //     );
  //   }
  // }

  // @override
  // Future<List<CategoryModel>> getCategories() async {
  //   try {
  //     final data = await API.dio.get(
  //       categoryEndPoint,
  //     );
  //     if (data.statusCode != 200 && data.statusCode != 201) {
  //       throw CustomFirebaseException(
  //         message: 'Failed to fetch data',
  //         code: data.statusCode,
  //       );
  //     }

  //     return (data.data['categories'] as List).map<CategoryModel>((category) {
  //       return CategoryModel.fromMap(category);
  //     }).toList();
  //   } catch (e) {
  //     throw CustomFirebaseException(
  //       message: e.toString(),
  //       code: 500,
  //     );
  //   }
  // }

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

    // if repeated items are found, combine them
    // List<CartModel> cartItemsCopy = List.from(cartItems); // Create a copy of cartItems
    // for (var element in cartItemsCopy) {
    //   int index = cartItems.indexWhere((item) => item.shoeId == element.shoeId);
    //   if (index != -1) {
    //     cartItems[index] = cartItems[index].copywith(
    //       quantity: cartItems[index].quantity + 1,
    //     );
    //     cartItems.removeWhere((item) => item.shoeId == element.shoeId);
    //   }
    // }
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

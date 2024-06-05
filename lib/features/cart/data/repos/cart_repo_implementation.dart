import 'package:dartz/dartz.dart';

import 'package:shoe_shop_app/core/error/exception.dart';
import 'package:shoe_shop_app/core/error/failure.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:shoe_shop_app/features/cart/data/models/cart_model.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/domain/repos/cart_repo.dart';

class CartRepoImplementation implements CartRepo {
  CartRepoImplementation(
    this._remoteDataSource,
  );
  final CartRemoteDataSource _remoteDataSource;

  @override
  ResultFutureVoid checkoutCart(
      List<CartItem> cartItems, double totalAmount) async {
    try {
      List<CartModel> cartModelItems = [];
      for (var element in cartItems) {
        cartModelItems.add(
          CartModel(
            shoeId: element.shoeId,
            shoeName: element.shoeName,
            shoeCategory: element.shoeCategory,
            shoeSize: element.shoeSize,
            shoeColor: element.shoeColor,
            quantity: element.quantity,
            shoeImage: element.shoeImage,
          ),
        );
      }

      await _remoteDataSource.checkoutCart(cartModelItems, totalAmount);
      return const Right(null);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }

  @override
  ResultFutureVoid deleteCart(String shoeId) async {
    try {
      await _remoteDataSource.deleteCartItem(shoeId);
      return const Right(null);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }

  @override
  ResultFuture<List<CartItem>> getCart() async {
    try {
      final data = await _remoteDataSource.getCartItems();
      return Right(data);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }

  @override
  ResultFutureVoid postCart(
      {required String shoeId,
      required String shoeName,
      required String shoeCategory,
      required int shoeSize,
      required String shoeColor,
      required int quantity,
      required String shoeImage}) async {
    try {
      if (quantity == 0) {
        return const Left(FirebaseFailure('Quantity cannot be zero', 400));
      } else if (quantity < 0) {
        return const Left(FirebaseFailure('Quantity cannot be negative', 400));
      }

      // get the cart items if they exist  update the quantity of the item
      final cartItems = await getCart();
      bool isItemExist = false;
      cartItems.fold((l) => null, (r) {
        for (var item in r) {
          if (item.shoeId == shoeId) {
            isItemExist = true;
            break;
          }
        }
      });
      if (isItemExist) {
        //  Update the quantity of the item
        await updateCartQuantity(quantity: quantity, shoeId: shoeId);

        return const Right(null);
      }

      final cartItem = CartModel(
          shoeId: shoeId,
          shoeName: shoeName,
          shoeCategory: shoeCategory,
          shoeSize: shoeSize,
          shoeColor: shoeColor,
          quantity: quantity,
          shoeImage: shoeImage);
      await _remoteDataSource.postCartItems(cartItem);
      return const Right(null);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }

  @override
  ResultFutureVoid updateCartQuantity(
      {required int quantity, required String shoeId}) async {
    try {
      await _remoteDataSource.updateCartItem(quantity++, shoeId);
      return const Right(null);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }
}

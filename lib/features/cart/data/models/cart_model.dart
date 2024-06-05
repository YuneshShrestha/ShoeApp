import 'dart:convert';

import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';

class CartModel extends CartItem {
  const CartModel({
 
   required super.shoeImage, required super.shoeName, required super.shoeCategory, required super.shoeSize, required super.shoeColor, required super.shoeId, required super.quantity, required super.price});

  const CartModel.empty() : super.empty();

  DataMap toMap() {
    return {
      'shoeImage': shoeImage,
      'shoeName': shoeName,
      'shoeCategory': shoeCategory,
      'shoeSize': shoeSize,
      'shoeColor': shoeColor,
      'shoeId': shoeId,
      'quantity': quantity,
      'price': price,
    };
  }

  String toJson() => jsonEncode(toMap());

  CartModel copywith({
    String? shoeImage,
    String? shoeName,
    String? shoeCategory,
    int? shoeSize,
    String? shoeColor,
    String? shoeId,
    int? quantity,
    int? price,
  }) {
    return CartModel(
      shoeImage: shoeImage ?? this.shoeImage,
      shoeName: shoeName ?? this.shoeName,
      shoeCategory: shoeCategory ?? this.shoeCategory,
      shoeSize: shoeSize ?? this.shoeSize,
      shoeColor: shoeColor ?? this.shoeColor,
      shoeId: shoeId ?? this.shoeId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}

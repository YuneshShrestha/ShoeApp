import 'dart:convert';
import 'package:shoe_shop_app/features/order_summary/domain/entities/order.dart';

class OrderModel extends OrderSummary {
  const OrderModel({
    required super.cartItems,
    required super.paymentMethod,
    required super.total,
    required super.orderID,
    required super.shippingFee,
    required super.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'cartItems': cartItems.map((e) => jsonEncode(e)).toList(),
      'paymentMethod': paymentMethod.index,
      'total': total,
      'orderID': orderID,
      'shippingFee': shippingFee,
      'location': location,
    };
  }
}

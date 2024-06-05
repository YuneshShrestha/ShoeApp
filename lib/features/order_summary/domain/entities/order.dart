import 'package:equatable/equatable.dart';
import 'package:shoe_shop_app/core/utils/enum.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';



class OrderSummary extends Equatable {
   final List<CartItem> cartItems;
   final PaymentMethod paymentMethod;
   final int total;
   final String orderID;
   final double shippingFee;
   final String location;


  const OrderSummary.empty()
      : cartItems = const [],
        paymentMethod = PaymentMethod.creditCard,
        total = 0,
        orderID = '',
        shippingFee = 0.0,
        location = '';

  const OrderSummary({required this.cartItems, required this.paymentMethod, required this.total, required this.orderID, required this.shippingFee, required this.location,});

  @override
  List<Object?> get props => [
        cartItems,
        paymentMethod,
        total,
        orderID,
        shippingFee,
        location,
      ];
}

import 'package:flutter/material.dart';
import 'package:shoe_shop_app/core/utils/api.dart';
import 'package:shoe_shop_app/core/utils/enum.dart';
import 'package:shoe_shop_app/core/widgets/custom_button.dart';

import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/order_summary/data/models/order_model.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key, required this.cartItems});

  final List<CartItem> cartItems;
  static const routeName = '/order';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(cartItems.toString()),
            Text('Total Price: \$${getTotalPrice()}'),
            customBlackButton(
              text: 'Checkout Success',
              onPressed: () async {
                OrderModel order = OrderModel(
                  cartItems: cartItems,
                  paymentMethod: PaymentMethod.creditCard,
                  total: getTotalPrice(),
                  orderID: '123',
                  shippingFee: 10.0,
                  location: 'Jakarta',
                );
                // Push to firebase
                try {
                  final data = await API.dio.post(
                    '/orders.json',
                    data: order.toJson(),
                  );
                  if (context.mounted &&
                      (data.statusCode == 200 || data.statusCode == 201)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Checkout Success'),
                      ),
                    );
                    Navigator.of(context).popUntil(
                      ModalRoute.withName('/'),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to checkout'),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  int getTotalPrice() {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].price * cartItems[i].quantity;
    }
    return total;
  }
}

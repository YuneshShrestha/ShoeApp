import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/core/widgets/custom_button.dart';
import 'package:shoe_shop_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoe_shop_app/features/cart/presentation/widget/cart_item_widge.dart';
import 'package:shoe_shop_app/features/order_summary/presentation/order_summary_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const routeName = '/cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(const GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Cart'),
    );
    return Scaffold(
      appBar: appBar,
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CartLoaded) {
            return state.cart.isEmpty
                ? const Center(
                    child: SizedBox(
                    child: Text("No Items Added To Cart."),
                  ))
                : SizedBox(
                    height: MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top -
                        20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                            itemCount: state.cart.length,
                            itemBuilder: (context, index) {
                              final cart = state.cart[index];
                              return CartItemWidget(cartItem: cart);
                            },
                          ),
                        ),
                        customBlackButton(
                          text: "Checkout",
                          onPressed: () {
                            Navigator.pushNamed(
                                context, OrderSummaryPage.routeName,
                                arguments: state.cart);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
          }
          return const Center(
            child: Text('No items in cart.'),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/features/cart/presentation/bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(state.runtimeType);
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final cart = state.cart[index];
                return ListTile(
                  title: Text(cart.shoeName),
                  subtitle: Text(cart.shoeCategory),
                  trailing: Text(cart.quantity.toString()),
                );
              },
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

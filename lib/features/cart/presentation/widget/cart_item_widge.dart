import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/presentation/bloc/cart_bloc.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        onDismissed: (direction) {
          context.read<CartBloc>().add(RemoveFromCartEvent(widget.cartItem));
        },
        key: ValueKey(widget.cartItem.shoeId.toString()),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Image.asset(
            'assets/logo/trash.png',
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ),
        child: ListTile(
          leading: Container(
            color: Colors.black26,
            width: 50,
            height: 50,
          ),
          title: Text(widget.cartItem.shoeName),
          subtitle: Text('Price: ${widget.cartItem.price}'),
          trailing: Text('Qty: ${widget.cartItem.quantity}'),
        ));
  }
}

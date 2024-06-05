part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {
  const CartInitial();
}

final class CartLoading extends CartState {
  const CartLoading();
}

final class CartLoaded extends CartState {
  final List<CartItem> cart;
  const CartLoaded(this.cart);

  @override
  List<Object> get props => [cart];
}

final class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object> get props => [message];
}

final class CartPosted extends CartState {
  const CartPosted();
}

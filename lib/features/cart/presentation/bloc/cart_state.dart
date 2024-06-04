part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartLoaded extends CartState {
  final List<CartItem> cart;
  final int total;
  const CartLoaded(this.cart, this.total);
  
  @override
  List<Object> get props => [cart, total];
}
final class CartError extends CartState {
  final String message;
  const CartError(this.message);
  
  @override
  List<Object> get props => [message];
}

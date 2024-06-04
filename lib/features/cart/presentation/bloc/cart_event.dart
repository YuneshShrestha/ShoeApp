part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartEvent extends CartEvent {
  const GetCartEvent();
}

class AddToCartEvent extends CartEvent {
  final CartItem cart;
  const AddToCartEvent(this.cart);

  @override
  List<Object> get props => [cart];
}
class RemoveFromCartEvent extends CartEvent {
  final CartItem cart;
  const RemoveFromCartEvent(this.cart);

  @override
  List<Object> get props => [cart];
}
class UpdateCartEvent extends CartEvent {
  final CartItem cart;
  const UpdateCartEvent(this.cart);

  @override
  List<Object> get props => [cart];
}
class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
class CheckoutCartEvent extends CartEvent {
  const CheckoutCartEvent();
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/domain/usecases/delete_cart.dart';
import 'package:shoe_shop_app/features/cart/domain/usecases/get_cart.dart';
import 'package:shoe_shop_app/features/cart/domain/usecases/post_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required GetCart getCart,
    required PostCart postCart,
    required DeleteCartItem deleteCartItem,
  })  : _getCart = getCart,
        _addToCart = postCart,
        _deleteCartItem = deleteCartItem,
        super(const CartInitial()) {
    on<GetCartEvent>(_getCartHandler);
    on<AddToCartEvent>(_addToCartHandler);
    on<RemoveFromCartEvent>(_removeFromCartHandler);
  }
  final GetCart _getCart;
  final PostCart _addToCart;
  final DeleteCartItem _deleteCartItem;

  Future<void> _getCartHandler(
      GetCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    final result = await _getCart();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(
        CartLoaded(cart),
      ),
    );
  }

  Future<void> _addToCartHandler(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());

    final result = await _addToCart(CartItem(
      shoeImage: event.cart.shoeImage,
      shoeName: event.cart.shoeName,
      shoeCategory: event.cart.shoeCategory,
      shoeSize: event.cart.shoeSize,
      shoeColor: event.cart.shoeColor,
      shoeId: event.cart.shoeId,
      quantity: event.cart.quantity,
      price: event.cart.price,
    ));

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(
        const CartPosted(),
      ),
    );
  }

  Future<void> _removeFromCartHandler(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    final result = await _deleteCartItem(event.cart.shoeId);
    result.fold((failure) => emit(CartError(failure.message)), (cart) {
      emit(const CartDeleted());
      add(const GetCartEvent());
    });
  }
}

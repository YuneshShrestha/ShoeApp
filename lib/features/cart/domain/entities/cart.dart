import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
   final String shoeImage;
   final String shoeName;
   final String shoeCategory;
    final int shoeSize;
    final String shoeColor;
    final int quantity;
    final int price;
    final String shoeId;
  const CartItem.empty()
      : shoeImage = '',
        shoeName = '',
        shoeCategory = '',
        shoeSize = 0,
        shoeColor = '',
        shoeId = '',
        quantity = 0,
        price = 0;


  const CartItem({
    required this.shoeImage,
    required this.shoeName,
    required this.shoeCategory,
    required this.shoeSize,
    required this.shoeColor,
    required this.shoeId,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [
        shoeImage,
        shoeName,
        shoeCategory,
        shoeSize,
        shoeColor,
        quantity,
        price,
      ];
}

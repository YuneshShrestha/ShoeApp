import 'package:equatable/equatable.dart';

class Shoe extends Equatable {
  final double avgRating;
  final String categoryID;
  final String imageUrl;
  final String name;
  final int numberOfReviews;
  final int price;
  final String productID;

  const Shoe.empty()
      : avgRating = 4.5,
        categoryID = '1',
        imageUrl = 'https://example.com/nike_air_max.jpg',
        name = 'Nike Air Max',
        numberOfReviews = 250,
        price = 120,
        productID = '1';

  const Shoe({
    required this.productID,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.avgRating,
    required this.numberOfReviews,
    required this.categoryID,
  });

  @override
  List<Object?> get props => [
        productID,
        name,
        imageUrl,
        price,
        avgRating,
        numberOfReviews,
        categoryID
      ];
}

import 'package:equatable/equatable.dart';

class Shoe extends Equatable {
  final double avgRating;
  final String categoryID;
  final String imageUrl;
  final String name;
  final int numberOfReviews;
  final int price;
  final String productID;
  final List<String> sizeOptions;
  final List<Map<String, dynamic>> colorOptions;
  final String description;

  const Shoe.empty()
      : avgRating = 4.5,
        categoryID = '1',
        imageUrl = 'https://example.com/nike_air_max.jpg',
        name = 'Nike Air Max',
        numberOfReviews = 250,
        price = 120,
        productID = '1',
        sizeOptions = const ['7', '8', '9', '10', '11'],
        colorOptions = const [
          {"color": "Red", "image": "Redimage"},
          {"color": "Blue", "image": "Blue Image"},
          {"color": "Yellow", "image": "Yellow Image"}
        ],
        description =
            "The Nike Air Max is a comfortable and stylish shoe, perfect for everyday wear.";

  const Shoe({
    required this.productID,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.avgRating,
    required this.numberOfReviews,
    required this.categoryID,
    required this.sizeOptions,
    required this.colorOptions,
    required this.description,
  });

  @override
  List<Object?> get props => [
        productID,
        name,
        imageUrl,
        price,
        avgRating,
        numberOfReviews,
        categoryID,
        sizeOptions,
        colorOptions,
        description,
      ];
}

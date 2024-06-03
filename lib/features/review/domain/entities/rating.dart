import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String productID;
  final int rating;
  final String ratingID;
  final String review;
  final String userID;

  const Rating({
    required this.productID,
    required this.rating,
    required this.ratingID,
    required this.review,
    required this.userID,
  });

  const Rating.empty()
      : productID = '1',
        rating = 5,
        ratingID = '1',
        review = 'Excellent shoe, very comfortable!',
        userID = '1';

  @override
  List<Object?> get props => [
        productID,
        rating,
        ratingID,
        review,
        userID,
  ];
}

import 'dart:convert';

import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';

class RatingModel extends Rating {
  const RatingModel({
    required super.productID,
    required super.rating,
    required super.ratingID,
    required super.review,
    required super.userID,
  });

  const RatingModel.empty() : super.empty();

  factory RatingModel.fromJson(String source) {
    return RatingModel.fromMap(jsonDecode(source) as DataMap);
  }
  factory RatingModel.fromMap(DataMap map) {
    return RatingModel(
      productID: map['product_id'].toString(),
      rating: int.parse((map['rating'] ?? 0).toString()),
      ratingID: map['rating_id'].toString(),
      review: map['review'].toString(),
      userID: map['user_id'].toString(),
    );
  }
  RatingModel copyWith({
    String? productID,
    int? rating,
    String? ratingID,
    String? review,
    String? userID,
  }) {
    return RatingModel(
      productID: productID ?? this.productID,
      rating: rating ?? this.rating,
      ratingID: ratingID ?? this.ratingID,
      review: review ?? this.review,
      userID: userID ?? this.userID,
    );
  }

  DataMap toMap() {
    return {
      'product_id': productID,
      'rating': rating,
      'rating_id': ratingID,
      'review': review,
      'user_id': userID,
    };
  }

  String toJson() => jsonEncode(toMap());
}

import 'dart:convert';

import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';

class ShoeModel extends Shoe {
  const ShoeModel({
    required super.avgRating,
    required super.categoryID,
    required super.imageUrl,
    required super.name,
    required super.numberOfReviews,
    required super.price,
    required super.productID,
    required super.colorOptions,
    required super.description,
    required super.sizeOptions,
  });
  const ShoeModel.empty() : super.empty();
  factory ShoeModel.fromJson(String source) {
    return ShoeModel.fromMap(jsonDecode(source) as DataMap);
  }
  factory ShoeModel.fromMap(DataMap map) {
    return ShoeModel(
      avgRating: double.parse((map['avg_rating'] ?? 0).toString()),
      categoryID: map['category_id'].toString(),
      imageUrl: map['image_url'].toString(),
      name: map['name'].toString(),
      numberOfReviews: int.parse((map['number_of_reviews'] ?? 0).toString()),
      price: int.parse((map['price'] ?? 0).toString()),
      productID: map['product_id'].toString(),
      colorOptions:  List<Map<String, dynamic>>.from(map['color_options'] ?? []),
      sizeOptions: map['size_options']?.cast<String>() ?? [],
      description: map['description'].toString(),
    );
  }

  ShoeModel copyWith({
    double? avgRating,
    String? categoryID,
    String? imageUrl,
    String? name,
    int? numberOfReviews,
    int? price,
    String? productID,
    List<Map<String, dynamic>>? colorOptions,
    List<String>? sizeOptions,
    String? description,
  }) {
    return ShoeModel(
      avgRating: avgRating ?? this.avgRating,
      categoryID: categoryID ?? this.categoryID,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      numberOfReviews: numberOfReviews ?? this.numberOfReviews,
      price: price ?? this.price,
      productID: productID ?? this.productID,
      colorOptions: colorOptions ?? this.colorOptions,
      sizeOptions: sizeOptions ?? this.sizeOptions,
      description: description ?? this.description,
    );
  }

  DataMap toMap() {
    return {
      'avg_rating': avgRating,
      'category_id': categoryID,
      'image_url': imageUrl,
      'name': name,
      'number_of_reviews': numberOfReviews,
      'price': price,
      'product_id': productID,
      'color_options': colorOptions,
      'size_options': sizeOptions,
      'description': description,
    };
  }

  String toJson() => jsonEncode(toMap());
}

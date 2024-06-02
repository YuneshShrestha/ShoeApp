import 'dart:convert';

import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  const CategoryModel.empty() : super.empty();

  factory CategoryModel.fromJson(String source) {
    return CategoryModel.fromMap(jsonDecode(source) as DataMap);
  }
  factory CategoryModel.fromMap(DataMap map) {
    return CategoryModel(
      id: map['category_id'].toString(),
      name: map['category_name'].toString(),
      imageUrl: map['category_image'].toString(),
    );
  }
  CategoryModel copyWith({String? id, String? name, String? imageUrl}) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  DataMap toMap() {
    return {
      'category_id': id,
      'category_name': name,
      'category_image': imageUrl,
    };
  }

  String toJson() => jsonEncode(toMap());
}

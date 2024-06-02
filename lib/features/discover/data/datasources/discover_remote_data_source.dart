import 'package:firebase_database/firebase_database.dart';
import 'package:shoe_shop_app/core/error/exception.dart';
import 'package:shoe_shop_app/features/discover/data/models/categories_model.dart';
import 'package:shoe_shop_app/features/discover/data/models/shoe_model.dart';

abstract class DiscoverRemoteDataSource {
  Future<List<ShoeModel>> getShoes();
  Future<List<CategoryModel>> getCategories();
}

class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  DiscoverRemoteDataSourceImpl(this._real);
  final FirebaseDatabase _real;

  @override
  Future<List<ShoeModel>> getShoes() async {
    try {
      final data = await _real.ref('product').child('products').once();
      List<ShoeModel> shoes = [];

      for (int i = 0; i < data.snapshot.children.length; i++) {
        var shoe =
            data.snapshot.children.elementAt(i).value as Map<Object?, Object?>;
        Map<String, dynamic> shoeMap = {};
        shoe.forEach((key, value) {
          shoeMap[key.toString()] = value;
        });

        shoes.add(ShoeModel.fromMap(
            shoeMap)); // Pass the Map<String, dynamic> to ShoeModel.fromMap
      }
      return shoes;
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 500,
      );
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final data = await _real.ref('category').child('categories').once();
      List<CategoryModel> categories = [];

      for (int i = 0; i < data.snapshot.children.length; i++) {
        var category =
            data.snapshot.children.elementAt(i).value as Map<Object?, Object?>;
        Map<String, dynamic> categoryMap = {};
        category.forEach((key, value) {
          categoryMap[key.toString()] = value;
        });

        categories.add(CategoryModel.fromMap(categoryMap));
      }
      return categories;
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 500,
      );
    }
  }
}

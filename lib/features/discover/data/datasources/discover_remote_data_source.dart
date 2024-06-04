import 'package:shoe_shop_app/core/error/exception.dart';
import 'package:shoe_shop_app/core/utils/api.dart';
import 'package:shoe_shop_app/core/utils/constants.dart';
import 'package:shoe_shop_app/features/discover/data/models/categories_model.dart';
import 'package:shoe_shop_app/features/discover/data/models/shoe_model.dart';

abstract class DiscoverRemoteDataSource {
  Future<List<ShoeModel>> getShoes();
  Future<List<CategoryModel>> getCategories();
}

class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  DiscoverRemoteDataSourceImpl();

  @override
  Future<List<ShoeModel>> getShoes() async {
    try {
      final data = await API.dio.get(
        productEndpoint,
      );
      if (data.statusCode != 200 && data.statusCode != 201) {
        throw CustomFirebaseException(
          message: 'Failed to fetch data',
          code: data.statusCode,
        );
      }
      Map<String, dynamic> dataMap = {};
      List<ShoeModel> shoes = [];

      if (data.data['products'] is Map<String, dynamic>) {
        dataMap.forEach((key, value) {
          shoes.add(ShoeModel.fromMap(value));
        });
        return shoes;
      } else  {
      shoes=  (data.data['products'] as List).map<ShoeModel>(
          (shoe) {
          return ShoeModel.fromMap(shoe);
          },
        ).toList();
        return shoes;
      }
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
      final data = await API.dio.get(
        categoryEndPoint,
      );
      if (data.statusCode != 200 && data.statusCode != 201) {
        throw CustomFirebaseException(
          message: 'Failed to fetch data',
          code: data.statusCode,
        );
      }

      return (data.data['categories'] as List).map<CategoryModel>((category) {
        return CategoryModel.fromMap(category);
      }).toList();
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 500,
      );
    }
  }
}

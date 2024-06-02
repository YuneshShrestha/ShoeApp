import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/category.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';

abstract class DiscoverRepo {
  ResultFuture<List<Shoe>> getShoes();
  ResultFuture<List<Category>> getCategories();
}

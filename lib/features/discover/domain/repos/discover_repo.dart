import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoes.dart';

abstract class DiscoverRepo {
  ResultFuture<List<Shoe>> getShoes();
}
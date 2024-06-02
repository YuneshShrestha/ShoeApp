import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/category.dart';
import 'package:shoe_shop_app/features/discover/domain/repos/discover_repo.dart';

class GetCategories extends UseCase<List<Category>> {
  final DiscoverRepo repo;
  GetCategories(this.repo);

  @override
  ResultFuture<List<Category>> call() async {
    return await repo.getCategories();
  }
}

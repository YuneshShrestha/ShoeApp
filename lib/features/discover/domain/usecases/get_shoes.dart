import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoes.dart';
import 'package:shoe_shop_app/features/discover/domain/repos/discover_repo.dart';

class GetShoes extends UseCase<List<Shoe>> {
  final DiscoverRepo repo;
  GetShoes(this.repo);

  @override
  ResultFuture<List<Shoe>> call() async {
    return await repo.getShoes();
  }
}

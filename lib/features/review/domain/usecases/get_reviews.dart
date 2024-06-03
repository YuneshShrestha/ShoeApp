import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';
import 'package:shoe_shop_app/features/review/domain/repos/review_repo.dart';

class GetReviews extends UseCaseWithTwoParam<List<Rating>, String, int> {
  final ReviewRepo repo;
  GetReviews(this.repo);

  @override
  ResultFuture<List<Rating>> call(String param1, int? param2) async {
    return await repo.getRatings(param1, param2);
  }
}

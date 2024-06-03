import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';

abstract class ReviewRepo {
  ResultFuture<List<Rating>> getRatings(String productId, int? ratingCount);
  ResultFutureVoid addRating({
    required String productId,
    required int rating,
    required String review,
    required String ratingId,
    required String userId,
  });
}

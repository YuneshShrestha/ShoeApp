import 'package:equatable/equatable.dart';
import 'package:shoe_shop_app/core/usecase/usecase.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/review/domain/repos/review_repo.dart';

class AddRating extends UseCaseWithParam<void, AddReviewParams> {
  final ReviewRepo repo;
  AddRating(this.repo);

  @override
  ResultFuture<void> call(AddReviewParams param) async {
    return await repo.addRating(
      productId: param.productId,
      rating: param.rating,
      review: param.review,
      ratingId: param.ratingId,
      userId: param.userId,
    );
  }
}

class AddReviewParams extends Equatable {
  final String productId;
  final int rating;
  final String review;
  final String ratingId;
  final String userId;

  const AddReviewParams({
    required this.productId,
    required this.rating,
    required this.review,
    required this.ratingId,
    required this.userId,
  });

  const AddReviewParams.empty()
      : productId = '',
        rating = 0,
        review = '',
        ratingId = '',
        userId = '';
  @override
  // TODO: implement props
  List<Object?> get props => [productId, rating, review, ratingId, userId];
}

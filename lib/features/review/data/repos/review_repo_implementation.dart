import 'package:dartz/dartz.dart';

import 'package:shoe_shop_app/core/error/exception.dart';
import 'package:shoe_shop_app/core/error/failure.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/review/data/datasources/review_remote_data_source.dart';
import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';
import 'package:shoe_shop_app/features/review/domain/repos/review_repo.dart';

class ReviewRepoImplementation implements ReviewRepo {
  ReviewRepoImplementation(
    this._remoteDataSource,
  );
  final ReviewRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Rating>> getRatings(String productId, int? ratingCount) async {
    try {
      final data = await _remoteDataSource.getRatings(
        productId,
        ratingCount,
      );
      return Right(data);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }

  @override
  ResultFutureVoid addRating({
    required String productId,
    required int rating,
    required String review,
    required String ratingId,
    required String userId,
  }) async {
    try {
      await _remoteDataSource.addRating(
        productId: productId,
        rating: rating,
        review: review,
        ratingId: ratingId,
        userId: userId,
      );
      return const Right(null);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }
}

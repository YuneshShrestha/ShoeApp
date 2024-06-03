import 'package:shoe_shop_app/core/error/exception.dart';
import 'package:shoe_shop_app/features/review/data/models/rating_model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class ReviewRemoteDataSource {
  Future<List<RatingModel>> getRatings(String productId, int? ratingLimit);
  Future<void> addRating({
    required String productId,
    required int rating,
    required String review,
    required String ratingId,
    required String userId,
  });
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  ReviewRemoteDataSourceImpl(this._real);
  final FirebaseDatabase _real;

  @override
  Future<void> addRating(
      {required String productId,
      required int rating,
      required String review,
      required String ratingId,
      required String userId}) async {
    try {
      final ref = _real.ref().child('rating').child('ratings');
      await ref.push().set({
        'product_id': productId,
        'rating': rating,
        'review': review,
        'rating_id': ratingId,
        'user_id': userId,
      });
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 500,
      );
    }
  }

  @override
  Future<List<RatingModel>> getRatings(
      String productId, int? ratingLimit) async {
    // trya
    try {
      final ref = _real.ref().child('rating').child('ratings');
      DatabaseEvent data;
      if (ratingLimit != null) {
        data = await ref
            .orderByChild("product_id")
            .equalTo(productId)
            .limitToFirst(ratingLimit)
            .once();
      } else {
        data = await ref.orderByChild("product_id").equalTo(productId).once();
      }

      final List<RatingModel> ratings = [];
      for (int i = 0; i < data.snapshot.children.length; i++) {
        final rating =
            data.snapshot.children.elementAt(i).value as Map<Object?, Object?>;
        Map<String, dynamic> shoeMap = {};
        rating.forEach((key, value) {
          shoeMap[key.toString()] = value;
        });
        ratings.add(RatingModel.fromMap(shoeMap));
      }
      return ratings;
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 500,
      );
    }
  }
}

/// The code you provided is a Dart implementation of a remote data source for handling reviews and
/// ratings in a shoe shop application. Here's a breakdown of what the code is doing:
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
      // // Check if product rating for user exists
      // final userRatingData = await ref
      //     .orderByChild("product_id")
      //     .equalTo(productId)
      //     .orderByChild("user_id")
      //     .equalTo(userId)
      //     .once();
      // print("Rating: ${userRatingData.snapshot.value}");
      // increase shoe rating count
      final userRatingData = await ref
        .orderByChild("product_id")
        .equalTo(productId)
        .once();
      bool userHasRated = false;
      for (int i = 0; i < userRatingData.snapshot.children.length; i++) {
        final rating = userRatingData.snapshot.children.elementAt(i).value as Map<Object?, Object?>;
        if (rating['user_id'] == userId) {
          userHasRated = true;
          break;
        }
      }
      if (userHasRated) {
        throw const CustomFirebaseException(
          message: 'User has already rated this product',
          code: 400,
        );
      }
      final productRef = _real.ref().child('product').child('products');
      final productData =
          await productRef.orderByChild("product_id").equalTo(productId).once();
      Map<Object?, Object?> fetchedProductMap = {};
    
      if (productData.snapshot.value is List<Object?>) {
        if ((productData.snapshot.value as List<Object?>)[0] == null) {
          fetchedProductMap = (productData.snapshot.value as List<Object?>)[1]
              as Map<Object?, Object?>;
        } else {
           fetchedProductMap = (productData.snapshot.value as List<Object?>)[0]
            as Map<Object?, Object?>;
        }
      } else {
        fetchedProductMap = ((productData.snapshot.value as Map<Object?,
                Object?>)[(int.parse(productId) - 1).toString()])
            as Map<Object?, Object?>;
      }

      Map<String, dynamic> productMap = {};
      fetchedProductMap.forEach((key, value) {
        productMap[key.toString()] = value;
      });
      final ratingCount = productMap['number_of_reviews'] as int;

    
      if (productData.snapshot.key == null) {
        throw const CustomFirebaseException(
          message: 'Product not found',
          code: 404,
        );
      }
      await productRef.child((int.parse(productId) - 1).toString()).update({
        'number_of_reviews': ratingCount + 1,
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

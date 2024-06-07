import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoe_shop_app/core/utils/auth.dart';

import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';
import 'package:shoe_shop_app/features/review/domain/usecases/add_reviews.dart';
import 'package:shoe_shop_app/features/review/domain/usecases/get_reviews.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc({
    required GetReviews getReviews,
    required AddRating addRating,
  })  : _getReviews = getReviews,
        _addRating = addRating,
        super(const ReviewBlocInitial()) {
    on<GetReviewsEvent>(_getReviewsHandler);
    on<PostReviewsEvent>(_postReviewsHandler);
    on<Get3ReviewsEvent>(_get3ReviewsHandler);
  }
  final GetReviews _getReviews;
  final AddRating _addRating;

  Future<void> _getReviewsHandler(
      GetReviewsEvent event, Emitter<ReviewState> emit) async {
    emit(const GetReviewLoading());
    final result = await _getReviews(event.productID, event.ratingCount);
    result.fold(
      (failure) => emit(ReviewError(failure.message)),
      (ratings) => emit(
        GetReviewLoaded(ratings),
      ),
    );
  }

  Future<void> _get3ReviewsHandler(
      Get3ReviewsEvent event, Emitter<ReviewState> emit) async {
    emit(const GetReviewLoading());
    final result = await _getReviews(event.productID, 3);
    result.fold(
      (failure) => emit(ReviewError(failure.message)),
      (ratings) => emit(
        Get3ReviewLoaded(ratings),
      ),
    );
  }

  Future<void> _postReviewsHandler(
      PostReviewsEvent event, Emitter<ReviewState> emit) async {
    emit(const PostReviewLoading());
    var isSignedIn = await Auth.isSignedIn();
    var auth = await Auth.signInAnonymously();

    if (auth == null) {
      emit(const ReviewError('Failed to authenticate'));
      return;
    }
    if (!isSignedIn) {
      emit(const AnonymousSignIn());
    }
    // check if user has already reviewed the product

    final result = await _addRating(
      AddReviewParams(
        productId: event.productId,
        rating: event.rating,
        review: event.review,
        ratingId: event.ratingId,
        userId: auth.uid,
      ),
    );
    result.fold(
      (failure) => emit(ReviewError(failure.message.contains("already rated")
          ? "You have already rated this product"
          : failure.message)),
      (categories) => emit(const PostReviewSuccess()),
    );
    // Trigger get reviews again
    add(GetReviewsEvent(event.productId, null));
  }
}

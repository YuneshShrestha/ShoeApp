import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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
  }
  final GetReviews _getReviews;
  final AddRating _addRating;

  Future<void> _getReviewsHandler(
      GetReviewsEvent event, Emitter<ReviewState> emit) async {
    emit(const GetReviewLoading());
    final result = await _getReviews(event.productID);
    result.fold(
      (failure) => emit(ReviewError(failure.message)),
      (ratings) => emit(
        GetReviewLoaded(ratings),
      ),
    );
  }

  Future<void> _postReviewsHandler(
      PostReviewsEvent event, Emitter<ReviewState> emit) async {
    emit(const PostReviewLoading());
    final result = await _addRating(
      AddReviewParams(
        productId: event.productId,
        rating: event.rating,
        review: event.review,
        ratingId: event.ratingId,
        userId: event.userId,
      ),
    );
    result.fold(
      (failure) => emit(ReviewError(failure.message)),
      (categories) => emit(const PostReviewSuccess()),
    );
  }
}

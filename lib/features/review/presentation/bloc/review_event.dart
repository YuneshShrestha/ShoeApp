part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class GetReviewsEvent extends ReviewEvent {
  final String productID;
  final int? ratingCount;
  const GetReviewsEvent(
    this.productID,
    this.ratingCount,
  );
}

class PostReviewsEvent extends ReviewEvent {
  const PostReviewsEvent({
    required this.productId,
    required this.rating,
    required this.review,
    required this.ratingId,
  });
  final String productId;
  final int rating;
  final String review;
  final String ratingId;
}

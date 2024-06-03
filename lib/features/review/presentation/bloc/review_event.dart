part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class GetReviewsEvent extends ReviewEvent {
  final String productID;
  const GetReviewsEvent(
    this.productID,
  );
}

class PostReviewsEvent extends ReviewEvent {
  const PostReviewsEvent({
    required this.productId,
    required this.rating,
    required this.review,
    required this.ratingId,
    required this.userId,
  });
  final String productId;
  final int rating;
  final String review;
  final String ratingId;
  final String userId;
}

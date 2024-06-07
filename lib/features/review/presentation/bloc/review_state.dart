part of 'review_bloc.dart';

@immutable
sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewBlocInitial extends ReviewState {
  const ReviewBlocInitial();
}
// Ananymous class
final class AnonymousSignIn extends ReviewState {
  const AnonymousSignIn();
}
// Getting Review states

final class GetReviewInitial extends ReviewState {
  const GetReviewInitial();
}

final class GetReviewLoading extends ReviewState {
  const GetReviewLoading();
}

final class GetReviewLoaded extends ReviewState {
  final List<Rating> reviews;
  const GetReviewLoaded(this.reviews);

  @override
  List<Object> get props => reviews.map((e) => e.ratingID).toList();
}
final class Get3ReviewLoaded extends ReviewState {
  final List<Rating> reviews;
  const Get3ReviewLoaded(this.reviews);

  @override
  List<Object> get props => reviews.map((e) => e.ratingID).toList();
}

// Posting Review states
final class PostReviewInitial extends ReviewState {
  const PostReviewInitial();
}

final class PostReviewLoading extends ReviewState {
  const PostReviewLoading();
}

final class PostReviewSuccess extends ReviewState {
  const PostReviewSuccess();
}

// Error states

final class ReviewError extends ReviewState {
  final String message;
  const ReviewError(this.message);
  @override
  List<Object> get props => [message];
}

part of 'discover_bloc.dart';

@immutable
sealed class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

final class DiscoverInitial extends DiscoverState {
  const DiscoverInitial();
}

final class DiscoverLoading extends DiscoverState {
  const DiscoverLoading();
}

final class DiscoverLoaded extends DiscoverState {
  final List<Shoe> shoes;
  const DiscoverLoaded(this.shoes);

  @override
  List<Object> get props => shoes.map((e) => e.productID).toList();
}

final class DiscoverError extends DiscoverState {
  final String message;
  const DiscoverError(this.message);
  @override
  List<Object> get props => [message];
}

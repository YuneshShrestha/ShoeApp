part of 'discover_bloc.dart';

@immutable
sealed class DiscoverEvent extends Equatable{
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}
class GetShoesEvent extends DiscoverEvent {
  const GetShoesEvent();
}

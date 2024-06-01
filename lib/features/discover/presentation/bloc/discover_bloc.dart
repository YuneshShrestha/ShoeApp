import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoes.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_shoes.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc({
    required GetShoes getShoes,
  })  : _getShoes = getShoes,
        super(const DiscoverInitial()) {
    on<GetShoesEvent>(_getShoesHandler);
  }
  final GetShoes _getShoes;

  Future<void> _getShoesHandler(
      GetShoesEvent event, Emitter<DiscoverState> emit) async {
    emit(const DiscoverLoading());
    final result = await _getShoes();
    result.fold(
      (failure) => emit(DiscoverError(failure.message)),
      (shoes) => emit(DiscoverLoaded(shoes)),
    );
  }
}

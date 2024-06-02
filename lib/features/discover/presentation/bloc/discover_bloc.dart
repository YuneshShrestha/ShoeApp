import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/category.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_categories.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_shoes.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc({
    required GetShoes getShoes,
    required GetCategories getCategories,
  })  : _getShoes = getShoes,
        _getCategories = getCategories,
        super(const DiscoverInitial()) {
    on<GetShoesEvent>(_getShoesHandler);
    on<GetCategoriesEvent>(_getCategoriesHandler);
    // on<GetShoesWithCategoriesEvent>(_getCategoriesHandler);
  }
  final GetShoes _getShoes;
  final GetCategories _getCategories;

  Future<void> _getShoesHandler(
      GetShoesEvent event, Emitter<DiscoverState> emit) async {
    emit(const DiscoverLoading());
    final result = await _getShoes();
    result.fold(
      (failure) => emit(DiscoverError(failure.message)),
      (shoes) => emit(ShoesLoaded(shoes)),
    );
  }

  Future<void> _getCategoriesHandler(
      GetCategoriesEvent event, Emitter<DiscoverState> emit) async {
    emit(const DiscoverLoading());
    final result = await _getCategories();
    result.fold(
      (failure) => emit(DiscoverError(failure.message)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }
}

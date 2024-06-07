// Service locator
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:shoe_shop_app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:shoe_shop_app/features/cart/data/repos/cart_repo_implementation.dart';
import 'package:shoe_shop_app/features/cart/domain/repos/cart_repo.dart';
import 'package:shoe_shop_app/features/cart/domain/usecases/delete_cart.dart';
import 'package:shoe_shop_app/features/cart/domain/usecases/get_cart.dart';
import 'package:shoe_shop_app/features/cart/domain/usecases/post_cart.dart';
import 'package:shoe_shop_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoe_shop_app/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:shoe_shop_app/features/discover/data/repos/discover_repo_implementation.dart';
import 'package:shoe_shop_app/features/discover/domain/repos/discover_repo.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_categories.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_shoes.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoe_shop_app/features/review/data/datasources/review_remote_data_source.dart';
import 'package:shoe_shop_app/features/review/data/repos/review_repo_implementation.dart';
import 'package:shoe_shop_app/features/review/domain/repos/review_repo.dart';
import 'package:shoe_shop_app/features/review/domain/usecases/add_reviews.dart';
import 'package:shoe_shop_app/features/review/domain/usecases/get_reviews.dart';
import 'package:shoe_shop_app/features/review/presentation/bloc/review_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(() => DiscoverBloc(getShoes: sl(), getCategories: sl()))
    ..registerFactory(() => ReviewBloc(getReviews: sl(), addRating: sl()))
    ..registerFactory(
        () => CartBloc(getCart: sl(), postCart: sl(), deleteCartItem: sl()))
    // Use cases
    ..registerLazySingleton(() => GetShoes(sl()))
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => GetReviews(sl()))
    ..registerLazySingleton(() => AddRating(sl()))
    ..registerLazySingleton(() => PostCart(sl()))
    ..registerLazySingleton(() => DeleteCartItem(sl()))
    ..registerLazySingleton(() => GetCart(sl()))
    // Repositories
    ..registerLazySingleton<DiscoverRepo>(
        () => DiscoverRepoImplementation(sl()))
    ..registerLazySingleton<ReviewRepo>(() => ReviewRepoImplementation(sl()))
    ..registerLazySingleton<CartRepo>(() => CartRepoImplementation(sl()))
    // Data sources
    ..registerLazySingleton<DiscoverRemoteDataSource>(
        () => DiscoverRemoteDataSourceImpl())
    ..registerLazySingleton<ReviewRemoteDataSource>(
        () => ReviewRemoteDataSourceImpl(
              sl(),
            ))
    ..registerLazySingleton<CartRemoteDataSource>(
        () => CartRemoteDataSourceImpl())
    ..registerLazySingleton(() => FirebaseDatabase.instance);
}

// Service locator
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:shoe_shop_app/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:shoe_shop_app/features/discover/data/repos/discover_repo_implementation.dart';
import 'package:shoe_shop_app/features/discover/domain/repos/discover_repo.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_shoes.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(() => DiscoverBloc(getShoes: sl()))
    // Use cases
    ..registerLazySingleton(() => GetShoes(sl()))
    // Repositories
    ..registerLazySingleton<DiscoverRepo>(
        () => DiscoverRepoImplementation(sl()))
    // Data sources
    ..registerLazySingleton<DiscoverRemoteDataSource>(
        () => DiscoverRemoteDataSourceImpl(sl()))
    ..registerLazySingleton(
      () => FirebaseDatabase.instance,
    );
}

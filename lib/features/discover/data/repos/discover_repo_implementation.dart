import 'package:dartz/dartz.dart';

import 'package:shoe_shop_app/core/error/exception.dart';
import 'package:shoe_shop_app/core/error/failure.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/category.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';
import 'package:shoe_shop_app/features/discover/domain/repos/discover_repo.dart';

class DiscoverRepoImplementation implements DiscoverRepo {
  DiscoverRepoImplementation(
    this._remoteDataSource,
  );
  final DiscoverRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Shoe>> getShoes() async {
    try {
      final data = await _remoteDataSource.getShoes();
      return Right(data);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }

  @override
  ResultFuture<List<Category>> getCategories() async{
    try {
      final data = await _remoteDataSource.getCategories();
      return Right(data);
    } on CustomFirebaseException catch (e) {
      return Left(
        FirebaseFailure(
          e.message.toString(),
          e.code as int,
        ),
      );
    }
  }
}

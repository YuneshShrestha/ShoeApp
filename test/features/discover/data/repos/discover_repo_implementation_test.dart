import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoe_shop_app/core/error/exception.dart';
import 'package:shoe_shop_app/core/error/failure.dart';
import 'package:shoe_shop_app/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:shoe_shop_app/features/discover/data/repos/discover_repo_implementation.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';

class MockDiscoverRemoteDataSrc extends Mock
    implements DiscoverRemoteDataSource {}

void main() {
  late DiscoverRemoteDataSource remoteDataSource;
  late DiscoverRepoImplementation repoImpl;
  const tException = CustomFirebaseException(
    message: 'error',
    code: 500,
  );

  setUp(() {
    remoteDataSource = MockDiscoverRemoteDataSrc();
    repoImpl = DiscoverRepoImplementation(remoteDataSource);
  });

  group('getShoes', () {
    test(
        'should return a list of [Shoe] when the call to remote source is successful',
        () async {
      // arrange
      when(() => remoteDataSource.getShoes())
          .thenAnswer((_) async => Future.value([]));
      // act
      final result = await repoImpl.getShoes();
      // assert
      expect(result, isA<Right<dynamic, List<Shoe>>>());
      verify(() => remoteDataSource.getShoes()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        '''should return a [FirebaseFailure] when the call to the remote source is unsuccessful''',
        () async {
      // arrange
      when(() => remoteDataSource.getShoes()).thenThrow(tException);
      // act
      final result = await repoImpl.getShoes();

      // assert
      expect(
        result,
        equals(
          Left(
            FirebaseFailure.fromException(tException),
          ),
        ),
      );
      verify(() => remoteDataSource.getShoes()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}

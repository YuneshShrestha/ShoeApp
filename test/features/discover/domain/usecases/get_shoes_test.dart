import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_shoes.dart';

import 'discover_repo.mock.dart';

void main() {
  late MockDiscoverRepo repository;
  late GetShoes usecase;

  setUp(() {
    repository = MockDiscoverRepo();
    usecase = GetShoes(repository);
  });
  const shoesListResponse = [
    Shoe.empty(),
  ];

  test('should call [DiscoverRepo.getShoes]', () async {
    // arrange
    when(() => repository.getShoes())
        .thenAnswer((_) async => const Right(shoesListResponse));
    // act
    final result = await usecase();
    // assert
    expect(
      result,
      const Right(shoesListResponse),
    );
    verify(() => repository.getShoes()).called(1);
    verifyNoMoreInteractions(repository);
  });
}

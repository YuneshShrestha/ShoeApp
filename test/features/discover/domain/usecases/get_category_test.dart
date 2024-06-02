import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/category.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_categories.dart';

import 'discover_repo.mock.dart';

void main() {
  late MockDiscoverRepo repository;
  late GetCategories usecase;

  setUp(() {
    repository = MockDiscoverRepo();
    usecase = GetCategories(repository);
  });
  const categoryListResponse = [
    Category.empty(),
  ];

  test('should call [AuthRepo.getUsers]', () async {
    // arrange
    when(() => repository.getCategories())
        .thenAnswer((_) async => const Right(categoryListResponse));
    // act
    final result = await usecase();
    // assert
    expect(
      result,
      const Right(categoryListResponse),
    );
    verify(() => repository.getCategories()).called(1);
    verifyNoMoreInteractions(repository);
  });
}

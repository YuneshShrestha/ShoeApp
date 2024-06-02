import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoe_shop_app/core/error/failure.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_categories.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_shoes.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

class MockGetDiscoverShoes extends Mock implements GetShoes {}

class MockGetCategories extends Mock implements GetCategories {}

void main() {
  late GetShoes mockGetShoes;
  late GetCategories mockGetCategories;
  late DiscoverBloc bloc;
  const firebaseFailure = FirebaseFailure("message", 400);

  setUp(() {
    mockGetShoes = MockGetDiscoverShoes();
    mockGetCategories = MockGetCategories();
    bloc =
        DiscoverBloc(getShoes: mockGetShoes, getCategories: mockGetCategories);
  });
  tearDown(() => bloc.close());
  test('initial state should be [DiscoverInitial]', () async {
    // assert
    expect(bloc.state, const DiscoverInitial());
  });

  group(
    "getShoes",
    () {
      blocTest(
        "should emit [DiscoverLoading, DiscoverLoaded] when data is gotten successfully",
        build: () {
          when(() => mockGetShoes()).thenAnswer((_) async => const Right([]));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetShoesEvent()),
        expect: () => const <DiscoverState>[
          DiscoverLoading(),
          ShoesLoaded([]),
        ],
        verify: (_) {
          verify(() => mockGetShoes()).called(1);
          verifyNoMoreInteractions(mockGetShoes);
        },
      );
    },
  );
  group("getCategories", () {
    blocTest(
      "should emit [DiscoverLoading, CategoriesLoaded] when data is gotten successfully",
      build: () {
        when(() => mockGetCategories())
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetCategoriesEvent()),
      expect: () => const <DiscoverState>[
        DiscoverLoading(),
        CategoriesLoaded([]),
      ],
      verify: (_) {
        verify(() => mockGetCategories()).called(1);
        verifyNoMoreInteractions(mockGetCategories);
      },
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoe_shop_app/core/error/failure.dart';
import 'package:shoe_shop_app/features/discover/domain/usecases/get_shoes.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

class MockGetDiscoverShoes extends Mock implements GetShoes {}

void main() {
  late GetShoes mockGetShoes;
  late DiscoverBloc bloc;
  const firebaseFailure = FirebaseFailure("message", 400);

  setUp(() {
    mockGetShoes = MockGetDiscoverShoes();
    bloc = DiscoverBloc(getShoes: mockGetShoes);
  });
  tearDown(() => bloc.close());
  test('initial state should be [DiscoverInitial]', () async {
    // assert
    expect(bloc.state, const DiscoverInitial());
  });

  group(
    "getUsers",
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
          DiscoverLoaded([]),
        ],
        verify: (_) {
          verify(() => mockGetShoes()).called(1);
          verifyNoMoreInteractions(mockGetShoes);
        },
      );
    },
  );
}

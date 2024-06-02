import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/data/models/categories_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = CategoryModel.empty();
  test(
    'should be a subclass of [CategoryModel] entity',
    () {
      // arrange
      // act
      // assert
      expect(tModel, isA<CategoryModel>());
    },
  );

  final toJson = fixtureReader('categories.json');
  final toMap = jsonDecode(toJson) as DataMap;

  // group('fromMap', () {
  //   test(
  //     'should return a [CategoryModel] with the right data',
  //     () {
  //       // arrange
  //       // act
  //       CategoryModel result = CategoryModel.fromMap(toMap);
  //       expect(result, equals(tModel));
  //       // expect(result, tModel);
  //     },
  //   );
  // });
  group('fromJson', () {
    test(
      'should return a [CategoryModel] with the right data',
      () {
        // arrange
        // act
        CategoryModel result = CategoryModel.fromJson(toJson);
        expect(result, equals(tModel));
        // expect(result, tModel);
      },
    );
  });
  group(
    'toMap',
    () {
      test(
        'should return a [DataMap with right data]',
        () {
          // arrange
          // act
          DataMap result = tModel.toMap();
          // assert
          expect(result, toMap);
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a [String] with right data',
        () {
          // arrange
          // act
          String result = tModel.toJson();
          final toJson = jsonEncode({
            "category_id": "1",
            "category_name": "Nike",
            "category_image": "https://example.com/nike_logo.jpg"
          });
          // assert
          expect(result, equals(toJson));
        },
      );
    },
  );

  group('copywith', () {
    test(
      'should return a [CategoryModel] with the right data',
      () {
        // arrange
        final tModelCopy = tModel.copyWith(
          name: 'Puma',
        );
        // act
        // assert
        // check if the copy has the right data and the original data
        expect(tModelCopy.name, equals('Puma'));
        expect(tModelCopy.id, equals("1"));
      },
    );
  });
}

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoe_shop_app/core/utils/typedef.dart';
import 'package:shoe_shop_app/features/discover/data/models/shoe_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = ShoeModel.empty();
  test(
    'should be a subclass of [ShoeModel] entity',
    () {
      // arrange
      // act
      // assert
      expect(tModel, isA<ShoeModel>());
    },
  );

  final toJson = fixtureReader('products.json');
  final toMap = jsonDecode(toJson) as DataMap;

  group('fromMap', () {
    test(
      'should return a [ShoeModel] with the right data',
      () {
        // arrange
        // act
        ShoeModel result = ShoeModel.fromMap(toMap);
        expect(result, equals(tModel));
        // expect(result, tModel);
      },
    );
  });
  group('fromJson', () {
    test(
      'should return a [ShowModel] with the right data',
      () {
        // arrange
        // act
        ShoeModel result = ShoeModel.fromJson(toJson);
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
            "avg_rating": 4.5,
            "category_id": "1",
            "image_url": "https://example.com/nike_air_max.jpg",
            "name": "Nike Air Max",
            "number_of_reviews": 250,
            "price": 120,
            "product_id": "1"
          });
          // assert
          expect(result, equals(toJson));
        },
      );
    },
  );

  group('copywith', () {
    test(
      'should return a [ShoeModel] with the right data',
      () {
        // arrange
        final tModelCopy = tModel.copyWith(
          price: 100,
        );
        // act
        // assert
        // check if the copy has the right data and the original data
        expect(tModelCopy.price, equals(100));
        expect(tModelCopy.avgRating, equals(4.5));
      },
    );
  });
}

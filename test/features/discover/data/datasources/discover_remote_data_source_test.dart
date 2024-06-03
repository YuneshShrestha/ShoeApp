// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:shoe_shop_app/core/error/exception.dart';
// import 'package:shoe_shop_app/features/discover/data/datasources/discover_remote_data_source.dart';
// import 'package:shoe_shop_app/features/discover/data/models/shoe_model.dart';

// // Mock classes
// class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

// class MockDatabaseReference extends Mock implements DatabaseReference {}

// class MockDataSnapshot extends Mock implements DataSnapshot {}

// void main() {
//   late MockFirebaseDatabase mockFirebaseDatabase;
//   late MockDatabaseReference mockDatabaseReference;
//   late MockDataSnapshot mockDataSnapshot;
//   late DiscoverRemoteDataSourceImpl dataSource;

//   setUp(() {
//     mockFirebaseDatabase = MockFirebaseDatabase();
//     mockDatabaseReference = MockDatabaseReference();
//     mockDataSnapshot = MockDataSnapshot();
//     dataSource = DiscoverRemoteDataSourceImpl(mockFirebaseDatabase);
//   });

//   test('should return list of ShoeModel when getShoes is called', () async {
//     // Arrange
//     final shoesData = [
//       {
//         'id': '1',
//         'name': 'Shoe 1',
//         'brand': 'Brand A',
//         // Add other shoe properties here
//       },
//       {
//         'id': '2',
//         'name': 'Shoe 2',
//         'brand': 'Brand B',
//         // Add other shoe properties here
//       }
//     ];

//     // Mock the DataSnapshot to return the shoes data
//     when(() => mockDataSnapshot.children).thenReturn(shoesData.map((shoe) {
//       final mockChildSnapshot = MockDataSnapshot();
//       when(() => mockChildSnapshot.value).thenReturn(shoe);
//       return mockChildSnapshot;
//     }).toList());

//     // Mock the FirebaseDatabase reference and once method
//     when(() => mockFirebaseDatabase.ref('product')).thenReturn(mockDatabaseReference);
//     when(() => mockDatabaseReference.child('products')).thenReturn(mockDatabaseReference);
//     // when(() => mockDatabaseReference.once()).thenAnswer((_) async => DatabaseEvent.snapshot(mockDataSnapshot));

//     // Act
//     final result = await dataSource.getShoes();

//     // Assert
//     expect(result, isA<List<ShoeModel>>());
//     expect(result.length, equals(2));
//     expect(result[0].name, equals('Shoe 1'));
//     expect(result[1].name, equals('Shoe 2'));
//   });

//   test('should throw CustomFirebaseException when an error occurs', () async {
//     // Arrange
//     when(() => mockFirebaseDatabase.ref('product')).thenThrow(Exception('Firebase error'));

//     // Act & Assert
//     expect(() => dataSource.getShoes(), throwsA(isA<CustomFirebaseException>()));
//   });
// }

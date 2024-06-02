import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  const Category.empty()
      : id = '1',
        name = 'Nike',
        imageUrl = 'https://example.com/nike_logo.jpg';

  @override
  List<Object?> get props => [id, name, imageUrl];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/features/discover/data/models/shoe_model.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/category.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoe_shop_app/features/product_detail/presentation/product_detail.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // late FirebaseDatabase _database;
  @override
  void initState() {
    super.initState();

    // _database = FirebaseDatabase.instance;
    getCategories();
  

    // getShoes();
  }

  // void getRatings() async {
  //   final db = FirebaseDatabase.instance;
  //   await ReviewRemoteDataSourceImpl(db).getRatings("1", null);
  // }

  // void addRating() async {
  //   final db = FirebaseDatabase.instance;
  //   await ReviewRemoteDataSourceImpl(db).addRating(
  //       productId: '2', rating: 5, review: 'Good', ratingId: '1', userId: '1');
  // }

  void getShoes() async {
    context.read<DiscoverBloc>().add(const GetShoesEvent());
  }

  void getCategories() async {
    context.read<DiscoverBloc>().add(const GetCategoriesEvent());
  }

  List<Category> categories = [];
  List<Shoe> shoes = [];

  List<Shoe> filterByCategory(String categoryID) {
    return shoes.where((shoe) => shoe.categoryID == categoryID).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscoverBloc, DiscoverState>(
      listener: (context, state) {
        if (state is DiscoverError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is CategoriesLoaded) {
          if (state.categories.isNotEmpty) {
            categories = state.categories;
          }
          getShoes();
        }
        if (state is ShoesLoaded) {
          shoes = state.shoes;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Discover'),
          ),
          body: state is DiscoverLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is CategoriesLoaded || state is ShoesLoaded
                  ? ListView.builder(
                      itemCount: shoes.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ProductDetail(
                                    shoe: ShoeModel(
                                  productID: shoes[index].productID,
                                  name: shoes[index].name,
                                  description: shoes[index].description,
                                  price: shoes[index].price,
                                  categoryID: shoes[index].categoryID,
                                  numberOfReviews: shoes[index].numberOfReviews,
                                  avgRating: shoes[index].avgRating,
                                  colorOptions: shoes[index].colorOptions,
                                  imageUrl: shoes[index].imageUrl,
                                  sizeOptions: shoes[index].sizeOptions,
                                )),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(shoes[index].name),
                              subtitle:
                                  Text(shoes[index].numberOfReviews.toString()),
                            ),
                          ),
                        );
                      })
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoe_shop_app/features/discover/domain/entities/category.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoe_shop_app/features/product_detail/presentation/product_detail.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});
  static const routeName = '/';

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
  List<Shoe> _shoeCopy = [];

  List<Shoe> filterByCategory(String? categoryID) {
    if (categoryID == null) {
      return _shoeCopy;
    }
    return _shoeCopy
        .where((element) => element.categoryID == categoryID)
        .toList();
  }

  int selectedCategory = 0;
  var vGap = const SizedBox(height: 30);

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
          _shoeCopy = List.from(shoes);
        }
      },
      builder: (context, state) {
        final appBar = AppBar(
          title: const Text(
            'Discover',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: Image.asset('assets/logo/bag-2.png'),
            ),
          ],
        );
        return Scaffold(
          appBar: appBar,
          body: state is DiscoverLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is CategoriesLoaded || state is ShoesLoaded
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          20,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 2,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      ProductDetail.routeName,
                                      arguments: categories[0],
                                    );
                                  },
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedCategory = 0;

                                        shoes = filterByCategory(null);
                                      });
                                    },
                                    child: Text(
                                      'All',
                                      style: TextStyle(
                                        color: selectedCategory == 0
                                            ? Colors.black
                                            : Colors.grey[500],
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                ...categories.map(
                                  (category) => TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedCategory =
                                            categories.indexWhere((element) =>
                                                    element.id == category.id) +
                                                1;
                                        shoes = filterByCategory(category.id);
                                      });
                                    },
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        color: selectedCategory ==
                                                categories.indexWhere(
                                                        (element) =>
                                                            element.id ==
                                                            category.id) +
                                                    1
                                            ? Colors.black
                                            : Colors.grey[500],
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          vGap,
                          Flexible(
                            flex: 20,
                            child: GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: shoes.length,
                              itemBuilder: (context, index) {
                                final shoe = shoes[index];

                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      ProductDetail.routeName,
                                      arguments: shoe,
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                            shoe.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              const Flexible(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  shoe.avgRating.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 2,
                                                child: Text(
                                                  '| ${shoe.numberOfReviews} Reviews',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                            '\$${shoe.price}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}

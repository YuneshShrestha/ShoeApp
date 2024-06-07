import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoe_shop_app/features/cart/presentation/view/cart_page.dart';
import 'package:shoe_shop_app/features/discover/data/models/shoe_model.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoe_shop_app/features/discover/presentation/widgets/custom_black_button.dart';
import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';

import 'package:shoe_shop_app/features/review/presentation/bloc/review_bloc.dart';
import 'package:shoe_shop_app/features/review/presentation/view/review_page.dart';
import 'package:shoe_shop_app/features/review/presentation/widgets/rating_widget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.shoe});
  final ShoeModel shoe;

  static const routeName = '/product_detail';

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late ShoeModel shoe;
  late List<Rating> rating = [];
  @override
  void initState() {
    super.initState();
    shoe = widget.shoe;
    getReviews();
  }

  void onReviewSuccess() {
    setState(() {
      shoe = shoe.copyWith(numberOfReviews: shoe.numberOfReviews + 1);
    });
  }

  void getShoes() async {
    context.read<DiscoverBloc>().add(const GetShoesEvent());
  }

  void getReviews() async {
    context.read<ReviewBloc>().add(Get3ReviewsEvent(shoe.productID));
  }

  var vgap = const SizedBox(height: 30);
  var widgetGap = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CartPage.routeName);
            },
            icon: Image.asset(
              'assets/logo/bag-2.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: BlocConsumer<ReviewBloc, ReviewState>(
        listener: (context, state) {
          if (state is ReviewError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is Get3ReviewLoaded) {
            setState(() {
              rating = state.reviews;
            });
          }
          if (state is PostReviewSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Review added successfully'),
              ),
            );
            onReviewSuccess();

            getShoes();
          }
        },
        builder: (context, state) {
          if (state is GetReviewLoading || state is PostReviewLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReviewError) {
            return Center(
              child: Text(state.message),
            );
          }

          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      vgap,
                      Text(
                        shoe.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      vgap,
                      Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                shoe.avgRating.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " (${shoe.numberOfReviews} Reviews)",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      vgap,
                      const Text(
                        "Size",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      vgap,
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var size in shoe.sizeOptions)
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.black45,
                                    ),
                                    vertical: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    size,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      vgap,
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      widgetGap,
                      Text(
                        shoe.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          color: Colors.black45,
                        ),
                      ),
                      vgap,
                      Text(
                        "Review (${shoe.numberOfReviews})",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Get reviews
                      for (var review in rating) ReviewsWidget(review: review),

                      // Get all reviews
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black45),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ReviewPage.routeName,
                                  arguments: shoe.productID,
                                );
                              },
                              child: const Text(
                                'View All Reviews',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Price:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          widgetGap,
                          Text(
                            '\$${shoe.sizeOptions[0]}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      customBlackButton(
                          text: "ADD TO CART",
                          onPressed: () {
                            {
                              context.read<CartBloc>().add(
                                    AddToCartEvent(
                                      CartItem(
                                        price: shoe.price,
                                        shoeImage: shoe.imageUrl,
                                        shoeName: shoe.name,
                                        shoeCategory: shoe.categoryID,
                                        shoeSize: int.parse(
                                            shoe.sizeOptions[0].toString()),
                                        shoeColor: shoe.colorOptions[0]
                                            ['color'],
                                        shoeId: shoe.productID,
                                        quantity: 1,
                                      ),
                                    ),
                                  );
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

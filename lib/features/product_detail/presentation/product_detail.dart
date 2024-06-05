import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoe_shop_app/features/cart/presentation/view/cart_page.dart';
import 'package:shoe_shop_app/features/discover/data/models/shoe_model.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';

import 'package:shoe_shop_app/features/review/presentation/bloc/review_bloc.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.shoe});
  final ShoeModel shoe;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late ShoeModel shoe;
  @override
  void initState() {
    super.initState();
    shoe = widget.shoe;
  }

  void onReviewSuccess() {
    setState(() {
      shoe = shoe.copyWith(numberOfReviews: shoe.numberOfReviews + 1);
    });
  }

  void getShoes() async {
    context.read<DiscoverBloc>().add(const GetShoesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => 
                  const CartPage(),
                
                ),
              );
            },
            icon: const Icon(Icons.shopping_bag_outlined),
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
          }

          return Column(
            children: [
              Text(widget.shoe.name),
              Text(widget.shoe.description),
              Text(widget.shoe.price.toString()),
              // Count of reviews
              Text(shoe.numberOfReviews.toString()),
              Text(widget.shoe.productID),

              ElevatedButton(
                onPressed: () {
                  context.read<ReviewBloc>().add(
                        PostReviewsEvent(
                          productId: widget.shoe.productID,
                          rating: 5,
                          review: 'Good',
                          ratingId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        ),
                      );
                },
                child: const Text('Add Review'),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              print(state.runtimeType);
            },
            builder: (context, state) {
            
              return FloatingActionButton.extended(
                onPressed: () {
                  context.read<CartBloc>().add(
                        AddToCartEvent(
                          CartItem(
                            price: shoe.price,
                            shoeImage: shoe.imageUrl,
                            shoeName: shoe.name,
                            shoeCategory: shoe.categoryID,
                            shoeSize: int.parse(shoe.sizeOptions[0].toString()),
                            shoeColor: shoe.colorOptions[0]['color'],
                            shoeId: shoe.productID,
                            quantity: 1,
                          ),
                        ),
                      );
                },
                label: const Text('Add To Cart'),
                icon: const Icon(Icons.add_shopping_cart_outlined),
              );
            },
          ),
        ],
      ),
    );
  }
}

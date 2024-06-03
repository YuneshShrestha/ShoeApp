import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';
import 'package:shoe_shop_app/features/review/presentation/bloc/review_bloc.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // late FirebaseDatabase _database;
  @override
  void initState() {
    super.initState();

    // _database = FirebaseDatabase.instance;
    getReviews('1');

    // getShoes();
  }

  void getReviews(String id) async {
    context.read<ReviewBloc>().add(GetReviewsEvent(id, 1));
  }

  List<Rating> ratings = [];
  List<Rating> getFilterRating(int? rating) {
    if (rating == null) {
      return ratings;
    } else {
      return ratings.where((element) => element.rating == rating).toList();
    }
  }

  int? starCount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewBloc, ReviewState>(
      listener: (context, state) {
        if (state is ReviewError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is GetReviewLoaded) {
          ratings = state.reviews;
        }
        if (state is AnonymousSignIn) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Anonymous Sign In'),
            ),
          );
        }
        if (state is PostReviewSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Review Added Successfully.'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Review Page'),
          ),
          body: state is GetReviewLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is GetReviewLoaded
                  ? Column(
                      children: [
                        // Filter Rating
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Text('${index + 1}'),
                                    const SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          starCount = index + 1;
                                        });
                                      },
                                      child: const Text('Filter'),
                                    ),
                                  ],
                                );
                              }),
                        ),

                        Text('Reviews: ${getFilterRating(starCount)}'),

                        ElevatedButton(
                          onPressed: () {
                            context.read<ReviewBloc>().add(
                                  PostReviewsEvent(
                                    productId: '2',
                                    rating: 5,
                                    review: 'Good',
                                    ratingId: DateTime.now().toString(),
                                  ),
                                );
                            getReviews('1');
                          },
                          child: const Text('Add Review'),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}

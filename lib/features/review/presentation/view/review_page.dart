import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/core/utils/constants.dart';
import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';
import 'package:shoe_shop_app/features/review/presentation/bloc/review_bloc.dart';
import 'package:shoe_shop_app/features/review/presentation/widgets/rating_widget.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.productId});
  final String productId;
  static const String routeName = '/review';

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // late FirebaseDatabase _database;
  @override
  void initState() {
    super.initState();

    // _database = FirebaseDatabase.instance;
    getReviews(widget.productId);

    // getShoes();
  }

  void getReviews(String id) async {
    context.read<ReviewBloc>().add(GetReviewsEvent(id, null));
  }

  List<Rating> ratings = [];
  List<Rating> _ratingCopy = [];

  List<Rating> getFilterRating(int? rating) {
    if (rating == null) {
      return _ratingCopy;
    } else {
      return _ratingCopy.where((element) => element.rating == rating).toList();
    }
  }

  int? starCount;
  List<int> stars = [1, 2, 3, 4, 5];
  var selectedStar = 0;
  var vGap = const SizedBox(
    height: 30,
  );
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
          _ratingCopy = state.reviews;
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
        final appBar = AppBar(
          title: Text(
            'Reviews (${ratings.length})',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: pagePadding,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    ratings.isNotEmpty
                        ? (ratings
                                    .map((e) => e.rating)
                                    .reduce((a, b) => a + b) /
                                ratings.length)
                            .toStringAsFixed(1)
                        : '0.0',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
        return Scaffold(
          appBar: appBar,
          body: state is GetReviewLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is GetReviewLoaded
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          20,
                      child: Column(
                        children: [
                          // Stars
                          Flexible(
                            flex: 2,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedStar = 0;
                                        ratings = _ratingCopy;
                                      });
                                    },
                                    child: Text(
                                      'All',
                                      style: TextStyle(
                                        color: selectedStar == 0
                                            ? Colors.black
                                            : Colors.grey[500],
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                ...stars.map(
                                  (star) => TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedStar = stars.indexWhere(
                                                (element) => element == star) +
                                            1;
                                        ratings = getFilterRating(star);
                                      });
                                    },
                                    child: Text(
                                      '$star Star',
                                      style: TextStyle(
                                        color: selectedStar == star
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: pagePadding,
                                ),
                                child: ListView.builder(
                                    itemCount: ratings.length,
                                    itemBuilder: (context, index) {
                                      return ReviewsWidget(
                                          review: ratings[index]);
                                    }),
                              )),

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
                            },
                            child: const Text('Add Review'),
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

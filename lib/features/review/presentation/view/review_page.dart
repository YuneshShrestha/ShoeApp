import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<ReviewBloc>().add(GetReviewsEvent(id));
  }

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
                  ? Text(
                      state.reviews.toString(),
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}

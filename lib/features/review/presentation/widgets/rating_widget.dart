import 'package:flutter/material.dart';
import 'package:shoe_shop_app/features/review/domain/entities/rating.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key, required this.review});
  final Rating review;

  @override
  Widget build(BuildContext context) {
    const vgap = SizedBox(height: 30);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black26,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (var i = 0; i < review.rating; i++)
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                for (var i = 0; i < 5 - review.rating; i++)
                  const Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  ),
              ],
            ),
            Text(
              review.review,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w200,
              ),
            ),
            vgap,
          ],
        ),
      ],
    );
  }
}

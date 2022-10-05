import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

  class MessagesContentLoading extends StatefulWidget {
  const MessagesContentLoading({Key? key}) : super(key: key);

  @override
  State<MessagesContentLoading> createState() => _MessagesContentLoadingState();
}

class _MessagesContentLoadingState extends State<MessagesContentLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        padding: const EdgeInsets.only(top: 7, left: 15, right: 15, bottom: 12),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30)
              ),
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 10,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}

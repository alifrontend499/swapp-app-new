import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SpotsContentLoading extends StatefulWidget {
  const SpotsContentLoading({Key? key}) : super(key: key);

  @override
  State<SpotsContentLoading> createState() => _SpotsContentLoadingState();
}

class _SpotsContentLoadingState extends State<SpotsContentLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        padding: const EdgeInsets.only(top: 7, left: 15, right: 20, bottom: 5),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 10,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  const SizedBox(height: 5),

                  Container(
                    height: 10,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 23,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30)
              ),
            ),
          ],
        ),
      )
    );
  }
}

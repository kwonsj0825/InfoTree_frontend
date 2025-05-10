import 'package:flutter/material.dart';
import 'review_screen.dart';
import '../models/review_target.dart';

class ReviewListScreen extends StatelessWidget {
  final List<ReviewTarget> reviewTargets;

  const ReviewListScreen({super.key, required this.reviewTargets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '리뷰 작성',
          style: TextStyle(color: const Color(0xFF62462B), fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF62462B)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: ListView.separated(
          itemCount: reviewTargets.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final target = reviewTargets[index];
            return Container(
              height: 67.0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F1E9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFB3926B)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        target.name,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        target.description,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReviewScreen(target: target), // item은 리뷰 대상 하나
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA3B18A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('리뷰 작성하기'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

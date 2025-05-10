import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/review_target.dart';

class ReviewScreen extends StatefulWidget {
  final ReviewTarget target;

  const ReviewScreen({super.key, required this.target});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 3.0;
  final TextEditingController _controller = TextEditingController();

  void _submitReview() {
    final content = _controller.text;
    debugPrint('⭐ 별점: $_rating');
    debugPrint('📝 리뷰 내용: $content');
    // TODO: 서버에 전송하거나 로컬 저장하기
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('리뷰가 등록되었습니다!')),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: const Color(0xFF62462B)),
        title: const Text(
          '리뷰 작성하기',
          style: TextStyle(color: const Color(0xFF62462B), fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.target.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF62462B),
                  ),
                ),
                const SizedBox(height: 8),
                RatingBar.builder(
                  itemSize: 28,
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xFF377639),
                  ),
                  unratedColor: Colors.grey[300],
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: '내용을 입력하세요',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF876B55)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF62462B), width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF377639),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  '리뷰 등록하기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
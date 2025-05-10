import 'package:flutter/material.dart';
import '../models/benefit.dart';
import 'benefit_detail_screen.dart';

class CategoryBenefitListScreen extends StatelessWidget {
  final String categoryId;
  final String title;
  final List<Benefit> allBenefits;

  const CategoryBenefitListScreen({
    super.key,
    required this.categoryId,
    required this.title,
    required this.allBenefits,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);

    final validBenefits = allBenefits.where((b) =>
    b.categories.contains(categoryId) &&
        !b.endDate.isBefore(todayOnly)
    ).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF62462B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: validBenefits.isEmpty
            ? const Center(
          child: Text('현재 이용 가능한 혜택이 없습니다. 😅',
              style: TextStyle(fontSize: 14, color: Colors.grey)),
        )
            : ListView.builder(
          itemCount: validBenefits.length,
          itemBuilder: (context, index) {
            final benefit = validBenefits[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BenefitDetailScreen(benefit: benefit),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F1E9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFB3926B)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            benefit.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF62462B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            benefit.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF62462B)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
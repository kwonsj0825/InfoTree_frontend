import 'package:flutter/material.dart';
import '../models/benefit.dart';
import 'benefit_detail_screen.dart';
import '../models/user.dart';

class RecommendScreen extends StatelessWidget {
  final List<Benefit> recommendedBenefits;

  RecommendScreen({
    super.key,
    List<Benefit>? recommendedBenefits,
  }) : recommendedBenefits = recommendedBenefits ?? dummyBenefits;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);

    final validBenefits = recommendedBenefits.where(
          (b) => !b.endDate.isBefore(todayOnly),
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            '혜택 추천',
            style: TextStyle(
              color: Color(0xFF62462B),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${dummyUser.name}님만을 위한 추천 혜택을 모아봤어요 😊',
              style: const TextStyle(
                  fontSize: 14, color: Colors.grey
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: validBenefits.isEmpty
                  ? const Center(
                child: Text(
                  '혜택이 없습니다. 😅',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
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
          ],
        ),
      ),
    );
  }
}
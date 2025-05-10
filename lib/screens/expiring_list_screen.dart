import 'package:flutter/material.dart';
import '../models/benefit.dart';
import 'benefit_detail_screen.dart';

class ExpiringListScreen extends StatelessWidget {
  final List<Benefit> benefits;

  const ExpiringListScreen({super.key, required this.benefits});

  String getDDayText(DateTime deadline) {
    final today = DateTime.now();
    final diff = deadline.difference(DateTime(today.year, today.month, today.day)).inDays;
    if (diff > 0) return 'D-$diff';
    if (diff == 0) return 'D-DAY';
    return '마감';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('곧 마감되는 혜택들'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF62462B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '남은 기간이 7일 이하인 혜택들만 표시됩니다.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: benefits.length,
                itemBuilder: (context, index) {
                  final benefit = benefits[index];
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
                          Container(
                            width: 80.0,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFA3B18A),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                getDDayText(benefit.endDate),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
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
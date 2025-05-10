import 'package:flutter/material.dart';
import '../models/benefit.dart';
import 'benefit_detail_screen.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  final List<Benefit> allBenefits;

  const SearchResultScreen({
    super.key,
    required this.query,
    required this.allBenefits,
  });

  @override
  Widget build(BuildContext context) {
    final queryLower = query.toLowerCase();

    final titleMatches = allBenefits.where(
          (b) => b.title.toLowerCase().contains(queryLower),
    );

    final descriptionMatches = allBenefits.where(
          (b) =>
      !b.title.toLowerCase().contains(queryLower) &&
          b.description.toLowerCase().contains(queryLower),
    );

    final results = [...titleMatches, ...descriptionMatches];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('“$query” 검색 결과'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF62462B),
      ),
      body: results.isEmpty
          ? const Center(
        child: Text(
          '검색 결과가 없습니다. 😢',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final benefit = results[index];
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
                  const Icon(Icons.chevron_right, color: Color(0xFFA3B18A)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
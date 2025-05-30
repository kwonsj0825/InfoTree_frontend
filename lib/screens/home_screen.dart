import 'dart:async';
import 'package:flutter/material.dart';
import 'expiring_list_screen.dart';
import 'search_result_screen.dart';
import '../models/benefit.dart';
import '../models/category.dart';
import 'category_benefit_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> recommendationImages = [
    'assets/sample1.jpg',
    'assets/sample2.jpg',
    'assets/sample3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % recommendationImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  String getDDayText(DateTime deadline) {
    final today = DateTime.now();
    final diff = deadline.difference(DateTime(today.year, today.month, today.day)).inDays;
    if (diff > 0) return 'D-$diff';
    if (diff == 0) return 'D-DAY';
    return '마감';
  }

  @override
  Widget build(BuildContext context) {
    final List<Benefit> soonExpiring = dummyBenefits.where((b) {
      final today = DateTime.now();
      final todayDateOnly = DateTime(today.year, today.month, today.day);
      final diff = b.endDate.difference(todayDateOnly).inDays;
      return diff >= 0 && diff <= 7;
    }).toList()
      ..sort((a, b) => a.endDate.compareTo(b.endDate));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(101),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'InfoTree',
                  style: TextStyle(
                    color: Color(0xFF62462B),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: '검색어를 입력하세요',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 6),
                          ),
                          onSubmitted: (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SearchResultScreen(
                                  query: value,
                                  allBenefits: dummyBenefits,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('오늘의 추천 혜택', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                itemCount: recommendationImages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        recommendationImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(recommendationImages.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.black87 : Colors.grey[400],
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(
              context,
              '곧 마감되는 혜택들',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExpiringListScreen(benefits: soonExpiring),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            if (soonExpiring.isNotEmpty) _buildExpiringCardList(soonExpiring),
            const SizedBox(height: 24),
            const Text('카테고리별 혜택', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: categories.map((cat) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryBenefitListScreen(
                          categoryId: cat.id,
                          title: cat.label,
                          allBenefits: dummyBenefits,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F1E9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFB3926B)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat.icon, size: 28, color: const Color(0xFFA3B18A)),
                        const SizedBox(height: 6),
                        Text(cat.label, style: const TextStyle(fontSize: 13, color: Color(0xFF62462B))),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {String? subtitle, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            if (onTap != null)
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: onTap,
              ),
          ],
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildExpiringCardList(List<Benefit> items) {
    return Column(
      children: items.take(2).map((item) {
        return Container(
          height: 55.0,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F1E9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFFB3926B)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.title, style: const TextStyle(fontSize: 14)),
              Container(
                width: 100.0,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFA3B18A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    getDDayText(item.endDate),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
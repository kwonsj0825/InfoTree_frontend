import 'package:flutter/material.dart';
import '../models/benefit.dart';
import '../models/user.dart';
import 'benefit_detail_screen.dart';

class LikesScreen extends StatefulWidget {
  final List<Benefit> allBenefits;

  const LikesScreen({super.key, required this.allBenefits});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  late List<Benefit> likedBenefits;
  dynamic selectedChannelId = 'all'; // 기본값: 전체
  List<dynamic> channelIds = [];

  @override
  void initState() {
    super.initState();
    likedBenefits = widget.allBenefits
        .where((b) => dummyUser.likes.contains(b.id))
        .toList();

    // 중복 없이 channelId 모으기
    final uniqueIds = likedBenefits
        .map((b) => b.channelId)
        .where((id) => id != null)
        .toSet()
        .toList();
    channelIds = ['all', ...uniqueIds]; // 'all' 포함
  }

  void _unlike(Benefit benefit) {
    setState(() {
      dummyUser.likes.remove(benefit.id);
      likedBenefits.removeWhere((b) => b.id == benefit.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = selectedChannelId == 'all'
        ? likedBenefits
        : likedBenefits.where((b) => b.channelId == selectedChannelId).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '내가 찜한 혜택',
          style: TextStyle(
            color: Color(0xFF62462B),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 상단 필터 바
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: channelIds.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final id = channelIds[index];
                final isSelected = selectedChannelId == id;

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedChannelId = id);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF62462B) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFB3926B)),
                    ),
                    child: Text(
                      id == 'all' ? '즐겨찾기' : '채널 $id',
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF62462B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(height: 1),

          // 좋아요 리스트
          Expanded(
            child: filtered.isEmpty
                ? const Center(
              child: Text(
                '찜한 혜택이 없습니다 😅',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final benefit = filtered[index];
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
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () => _unlike(benefit),
                        ),
                        const SizedBox(width: 8),
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
    );
  }
}
import 'package:flutter/material.dart';
import '../models/benefit.dart';
import '../models/user.dart'; // dummyUser가 정의되어 있다고 가정

class BenefitDetailScreen extends StatefulWidget {
  final Benefit benefit;

  const BenefitDetailScreen({super.key, required this.benefit});

  @override
  State<BenefitDetailScreen> createState() => _BenefitDetailScreenState();
}

class _BenefitDetailScreenState extends State<BenefitDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLiked = false;
  bool isNotified = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    isLiked = dummyUser.likes.contains(widget.benefit.id);
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        dummyUser.likes.remove(widget.benefit.id);
      } else {
        dummyUser.likes.add(widget.benefit.id);
      }
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF62462B)),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF62462B),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF62462B),
            tabs: [
              Tab(text: '상세 정보'),
              Tab(text: '리뷰'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDetailTab(),
            const Center(child: Text('리뷰 탭 구현 예정')),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTab() {
    final benefit = widget.benefit;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      if (widget.benefit.image != null && widget.benefit.image!.isNotEmpty)
      Image.network(
      widget.benefit.image!,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(
          height: 200,
          child: Center(child: Text('이미지를 불러올 수 없습니다.')),
        );
      },
    )
    else Container(
    height: 200,
    color: Colors.grey[200],
    child: Center(child: Text('이미지가 없습니다.')),
    ),
    Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        benefit.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF62462B),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: toggleLike,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('알림 설정', style: TextStyle(color: Color(0xFF62462B))),
                    IconButton(
                      icon: Icon(
                        isNotified ? Icons.notifications : Icons.notifications_none,
                        color: isNotified ? Colors.yellow[600] : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => isNotified = !isNotified);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  benefit.description,
                  style: const TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: 방문 완료 처리
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF377639),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('방문 완료', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
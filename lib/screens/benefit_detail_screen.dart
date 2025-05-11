import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import '../models/benefit.dart';
import '../models/user.dart';

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
  String? _address;

  bool isVisited = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    isLiked = dummyUser.likes.contains(widget.benefit.id);
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    final lat = widget.benefit.latitude;
    final lng = widget.benefit.longitude;

    if (lat != null && lng != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          setState(() {
            _address =
            '${p.street ?? ''} ${p.locality ?? ''} ${p.administrativeArea ?? ''}';
          });
        }
      } catch (e) {
        setState(() {
          _address = '주소를 불러올 수 없습니다.';
        });
      }
    } else {
      _address = '위치 정보 없음';
    }
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
    final dateFormat = DateFormat('yyyy.MM.dd');

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (benefit.image != null && benefit.image!.isNotEmpty)
            Image.network(
              benefit.image!,
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
          else
            Container(
              height: 200,
              color: Colors.grey[200],
              child: const Center(child: Text('이미지가 없습니다.')),
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
                    Text(
                      '${benefit.likes}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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

                // 날짜
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.calendar_today, size: 20, color: Color(0xFF62462B)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '기간: ${dateFormat.format(benefit.startDate)} ~ ${dateFormat.format(benefit.endDate)}',
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 주소
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.place, size: 20, color: Color(0xFF62462B)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '주소: ${_address ?? '불러오는 중...'}',
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 설명
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.notes, size: 20, color: Color(0xFF62462B)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        benefit.description,
                        style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                const Divider(),

                Center(
                  child: ElevatedButton(
                    onPressed: isVisited
                        ? null
                        : () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('방문 완료 처리'),
                          content: const Text('방문 완료 처리하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('아니오'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('예'),
                            ),
                          ],
                        ),
                      );

                      if (result == true) {
                        setState(() {
                          isVisited = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isVisited
                          ? const Color(0xFFA3B18A)
                          : const Color(0xFF377639),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      isVisited ? '방문 완료됨' : '방문 완료',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

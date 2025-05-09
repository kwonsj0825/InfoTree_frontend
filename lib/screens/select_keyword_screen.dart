import 'package:flutter/material.dart';

class SelectKeywordScreen extends StatefulWidget {
  const SelectKeywordScreen({super.key});

  @override
  State<SelectKeywordScreen> createState() => _SelectKeywordScreenState();
}

class _SelectKeywordScreenState extends State<SelectKeywordScreen> {
  final List<Map<String, String>> categories = [
    {'id': 'university', 'label': '대학'},
    {'id': 'education', 'label': '교육'},
    {'id': 'it', 'label': 'IT'},
    {'id': 'trip', 'label': '여행'},
    {'id': 'development', 'label': '개발'},
    {'id': 'architect', 'label': '건축'},
    {'id': 'marketing', 'label': '마케팅'},
    {'id': 'startup', 'label': '스타트업'},
    {'id': 'career', 'label': '커리어'},
    {'id': 'resume', 'label': '자기소개서'},
    {'id': 'presentation', 'label': '발표'},
    {'id': 'leadership', 'label': '리더십'},
    {'id': 'cafe', 'label': '카페'},
    {'id': 'food', 'label': '음식'},
    {'id': 'plant', 'label': '식물'},
    {'id': 'car', 'label': '차'},
    {'id': 'drink', 'label': '음주'},
    {'id': 'dance', 'label': '댄스'},
    {'id': 'dessert', 'label': '간식'},
    {'id': 'celeb', 'label': '연예'},
    {'id': 'shopping', 'label': '쇼핑'},
    {'id': 'book', 'label': '책'},
    {'id': 'finance', 'label': '금융'},
    {'id': 'beauty', 'label': '뷰티'},
    {'id': 'hospital', 'label': '병원'},
    {'id': 'appliance', 'label': '가전'},
    {'id': 'health', 'label': '헬스'},
    {'id': 'sport', 'label': '스포츠'},
    {'id': 'yoga', 'label': '요가'},
    {'id': 'hair', 'label': '헤어'},
    {'id': 'cinema', 'label': '영화'},
    {'id': 'animal', 'label': '동물'},
    {'id': 'art', 'label': '미술'},
    {'id': 'entertainment', 'label': '예능'},
    {'id': 'museum', 'label': '박물관'},
    {'id': 'music', 'label': '음악'},
    {'id': 'photo', 'label': '사진'},
    {'id': 'volunteering', 'label': '봉사'},
    {'id': 'media', 'label': '방송'},
  ];

  final Map<String, IconData> categoryIcons = {
    'university': Icons.school,
    'education': Icons.menu_book,
    'it': Icons.computer,
    'trip': Icons.flight_takeoff,
    'development': Icons.code,
    'architect': Icons.architecture,
    'marketing': Icons.campaign,
    'startup': Icons.lightbulb,
    'career': Icons.work,
    'resume': Icons.description,
    'presentation': Icons.present_to_all,
    'leadership': Icons.groups,
    'cafe': Icons.local_cafe,
    'food': Icons.restaurant,
    'plant': Icons.park,
    'car': Icons.directions_car,
    'drink': Icons.local_bar,
    'dance': Icons.directions_run,
    'dessert': Icons.icecream,
    'celeb': Icons.star,
    'shopping': Icons.shopping_bag,
    'book': Icons.book,
    'finance': Icons.attach_money,
    'beauty': Icons.brush,
    'hospital': Icons.local_hospital,
    'appliance': Icons.kitchen,
    'health': Icons.health_and_safety,
    'sport': Icons.sports,
    'yoga': Icons.self_improvement,
    'hair': Icons.cut,
    'cinema': Icons.movie,
    'animal': Icons.pets,
    'art': Icons.palette,
    'entertainment': Icons.music_note,
    'museum': Icons.museum,
    'music': Icons.library_music,
    'photo': Icons.camera_alt,
    'volunteering': Icons.volunteer_activism,
    'media': Icons.tv,
  };

  final Set<String> selected = {};

  void _submit() {
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('카테고리를 하나 이상 선택해주세요.')),
      );
      return;
    }

    // TODO: 회원가입 최종 처리
    print('선택된 카테고리: $selected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          '관심 카테고리 선택',
          style: TextStyle(color: Color(0xFF62462B), fontSize: 20),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF62462B),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '관심 있는 카테고리를 하나 이상 선택해주세요.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
                children: categories.map((cat) {
                  final isSelected = selected.contains(cat['id']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selected.remove(cat['id']);
                        } else {
                          selected.add(cat['id']!);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Color(0xFF83AC55) : Colors.grey.shade400,
                          width: isSelected ? 3.0 : 2.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            categoryIcons[cat['id']] ?? Icons.category,
                            color: isSelected ? Color(0xFF83AC55) : Colors.black87,
                            size: 28,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            cat['label']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Color(0xFF83AC55) : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF377639),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('가입 완료', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
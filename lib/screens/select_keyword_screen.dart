import 'package:flutter/material.dart';
import '../models/category.dart';
import 'login_screen.dart';

class SelectKeywordScreen extends StatefulWidget {
  const SelectKeywordScreen({super.key});

  @override
  State<SelectKeywordScreen> createState() => _SelectKeywordScreenState();
}

class _SelectKeywordScreenState extends State<SelectKeywordScreen> {
  final Set<String> selected = {};

  void _submit() {
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('카테고리를 하나 이상 선택해주세요.')),
      );
      return;
    }

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
          icon: const Icon(Icons.arrow_back, color: Color(0xFF62462B)),
          onPressed: () => Navigator.pop(context),
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
                  final isSelected = selected.contains(cat.id);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected ? selected.remove(cat.id) : selected.add(cat.id);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF83AC55) : Colors.grey.shade400,
                          width: isSelected ? 3.0 : 2.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cat.icon,
                            color: isSelected ? const Color(0xFF83AC55) : Colors.black87,
                            size: 28,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            cat.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? const Color(0xFF83AC55) : Colors.black87,
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
                onPressed: () {
                  if (selected.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('카테고리를 하나 이상 선택해주세요.')),
                    );
                    return;
                  }

                  // 스낵바로 가입 완료 안내
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('가입이 완료되었습니다!')),
                  );

                  // 1초 후 로그인 화면으로 이동 (스택 완전 초기화)
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (Route<dynamic> route) => false,
                    );
                  });
                },
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
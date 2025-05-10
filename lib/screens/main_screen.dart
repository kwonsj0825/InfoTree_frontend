import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'mypage_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2; // 홈 탭이 기본

  final List<Widget> _screens = const [
    Placeholder(), // 지도
    Placeholder(), // 내 혜택
    HomeScreen(),
    Placeholder(), // 내 구독
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF377639),
        unselectedItemColor: const Color(0xFFA3B18A),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedIconTheme: const IconThemeData(size: 26),
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          _buildNavItem(Icons.map, '지도', 0),
          _buildNavItem(Icons.star, '추천', 1),
          _buildNavItem(Icons.home, '홈', 2, isCenter: true),
          _buildNavItem(Icons.favorite, '좋아요', 3),
          _buildNavItem(Icons.person, '마이', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index, {bool isCenter = false}) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
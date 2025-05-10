import 'package:flutter/material.dart';

class Category {
  final String id;
  final String label;
  final IconData icon;
  final String iconPath; // ✅ 마커용 이미지 경로 추가

  Category({
    required this.id,
    required this.label,
    required this.icon,
    required this.iconPath,
  });
}

final List<Category> categories = [
  Category(id: 'education', label: '교육', icon: Icons.menu_book, iconPath: 'assets/icons/education.png'),
  Category(id: 'intern', label: '인턴십', icon: Icons.business_center, iconPath: 'assets/icons/intern.png'),
  Category(id: 'job', label: '취업', icon: Icons.work_outline, iconPath: 'assets/icons/job.png'),
  Category(id: 'finance', label: '금융', icon: Icons.attach_money, iconPath: 'assets/icons/finance.png'),
  Category(id: 'scholarship', label: '장학금', icon: Icons.school, iconPath: 'assets/icons/scholarship.png'),
  Category(id: 'food', label: '음식', icon: Icons.restaurant, iconPath: 'assets/icons/food.png'),
  Category(id: 'cafe', label: '카페', icon: Icons.local_cafe, iconPath: 'assets/icons/cafe.png'),
  Category(id: 'health', label: '건강', icon: Icons.health_and_safety, iconPath: 'assets/icons/health.png'),
  Category(id: 'contest', label: '공모전', icon: Icons.emoji_events, iconPath: 'assets/icons/contest.png'),
  Category(id: 'competition', label: '대회', icon: Icons.emoji_events_outlined, iconPath: 'assets/icons/competition.png'),
  Category(id: 'trip', label: '여행', icon: Icons.flight_takeoff, iconPath: 'assets/icons/trip.png'),
  Category(id: 'volunteer', label: '봉사', icon: Icons.volunteer_activism, iconPath: 'assets/icons/volunteer.png'),
  Category(id: 'shopping', label: '쇼핑', icon: Icons.shopping_bag, iconPath: 'assets/icons/shopping.png'),
  Category(id: 'youth_policy', label: '청년 정책', icon: Icons.policy, iconPath: 'assets/icons/youth_policy.png'),
  Category(id: 'etc', label: '기타', icon: Icons.more_horiz, iconPath: 'assets/icons/etc.png'),
];

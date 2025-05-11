import 'package:flutter/material.dart';

class Category {
  final String id;
  final String label;
  final IconData icon;

  Category({
    required this.id,
    required this.label,
    required this.icon,
  });
}

final List<Category> categories = [
  Category(id: 'education', label: '교육', icon: Icons.menu_book),
  Category(id: 'intern', label: '인턴십', icon: Icons.business_center),
  Category(id: 'job', label: '취업', icon: Icons.work_outline),
  Category(id: 'finance', label: '금융', icon: Icons.attach_money),
  Category(id: 'scholarship', label: '장학금', icon: Icons.school),
  Category(id: 'food', label: '음식', icon: Icons.restaurant),
  Category(id: 'cafe', label: '카페', icon: Icons.local_cafe),
  Category(id: 'health', label: '건강', icon: Icons.health_and_safety),
  Category(id: 'contest', label: '공모전', icon: Icons.emoji_events),
  Category(id: 'competition', label: '대회', icon: Icons.emoji_events_outlined),
  Category(id: 'trip', label: '여행', icon: Icons.flight_takeoff),
  Category(id: 'volunteer', label: '봉사', icon: Icons.volunteer_activism),
  Category(id: 'shopping', label: '쇼핑', icon: Icons.shopping_bag),
  Category(id: 'youth_policy', label: '청년 정책', icon: Icons.policy),
  Category(id: 'etc', label: '기타', icon: Icons.more_horiz),
];

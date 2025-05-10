class Benefit {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final int ownerId;
  final bool isPrivate;
  final List<String> categories;
  final int? channelId;
  final String? image;
  final String? link;
  final double? latitude;
  final double? longitude;
  final int likes;

  Benefit({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.ownerId,
    required this.isPrivate,
    required this.categories,
    this.channelId,
    this.image,
    this.link,
    this.latitude,
    this.longitude,
    this.likes = 0,
  });

  factory Benefit.fromJson(Map<String, dynamic> json) {
    return Benefit(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      description: json['description'],
      ownerId: json['owner_id'],
      isPrivate: json['private'] ?? false,
      categories: List<String>.from(json['categories'] ?? []),
      channelId: json['channel_id'],
      image: json['image'],
      link: json['link'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      likes: json['likes'] ?? 0,
    );
  }
}

// 혜택 더미 데이터
final List<Benefit> dummyBenefits = [
  Benefit(
    id: 1,
    title: '조기 마감 할인',
    startDate: DateTime(2025, 5, 1),
    endDate: DateTime(2025, 5, 14),
    description: '3일 이내 종료되는 인기 혜택',
    ownerId: 1,
    isPrivate: false,
    categories: ['education'],
    likes: 0,
    latitude: 37.5665,
    longitude: 126.9780,
  ),
  Benefit(
    id: 2,
    title: '학생 한정 이벤트',
    startDate: DateTime(2025, 5, 2),
    endDate: DateTime(2025, 5, 12),
    description: '대학생만 참여 가능! 오늘만!',
    ownerId: 1,
    isPrivate: false,
    categories: ['finance'],
    likes: 0,
  ),
  Benefit(
    id: 3,
    title: '스타벅스',
    startDate: DateTime(2025, 5, 3),
    endDate: DateTime(2025, 5, 11),
    description: '아메리카노 10% 할인',
    ownerId: 1,
    isPrivate: false,
    categories: ['cafe'],
    likes: 0,
  ),
];

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
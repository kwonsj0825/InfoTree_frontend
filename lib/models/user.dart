class User {
  final int id;
  final String name;
  String school;
  final String email;
  final String phone;
  List<String> major;
  final List<int> channel;
  final List<String> keywords;
  final List<int> likes;
  String password;

  User({
    required this.id,
    required this.name,
    required this.school,
    required this.email,
    required this.phone,
    required this.major,
    required this.channel,
    required this.keywords,
    required this.likes,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      school: json['school'],
      email: json['email'],
      phone: json['phone'],
      major: List<String>.from(json['major'] ?? []),
      channel: List<int>.from(json['channel'] ?? []),
      keywords: List<String>.from(json['keywords'] ?? []),
      likes: List<int>.from(json['likes'] ?? []),
      password: json['password'] ?? '', // password는 nullable 처리 가능
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'school': school,
      'email': email,
      'phone': phone,
      'major': major,
      'channel': channel,
      'keywords': keywords,
      'likes': likes,
      'password': password,
    };
  }
}
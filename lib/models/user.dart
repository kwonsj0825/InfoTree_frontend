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
}

// 예시 사용자 - 어디서든 import해서 사용 가능
User dummyUser = User(
  id: 1,
  name: '홍길동',
  school: '동국대학교',
  email: 'hong@example.com',
  phone: '010-1234-5678',
  major: ['컴퓨터공학'],
  channel: [],
  keywords: [],
  likes: [],
  password: 'pass1234',
);
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/select_keyword_screen.dart';
import 'screens/main_screen.dart';
import 'models/user.dart';

final User dummyUser = User(
  id: 1,
  name: '홍길동',
  school: '동국대학교',
  email: 'hong@example.com',
  phone: '010-1234-5678',
  major: ['컴퓨터공학'],
  channel: [],
  keywords: [],
  likes: [],
  password: 'info1234',
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InfoTree',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/select_keywords': (context) => const SelectKeywordScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}

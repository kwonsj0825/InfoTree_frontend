import 'package:flutter/material.dart';
import 'review_list_screen.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import '../models/review_target.dart';
import '../main.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 리뷰용 더미 데이터
    final List<ReviewTarget> reviewTargets = [
      ReviewTarget(name: '스타벅스 아메리카노', description: '10% 할인 혜택'),
      ReviewTarget(name: '학생 전용 할인', description: '3일 남음'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFF6F1E9),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummyUser.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF62462B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dummyUser.school,
                        style: const TextStyle(fontSize: 14, color: Color(0xFF62462B)),
                      ),
                      Text(
                        dummyUser.major.join(', '),
                        style: const TextStyle(fontSize: 14, color: Color(0xFF62462B)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildButton(context, '프로필 수정하기', reviewTargets),
            const SizedBox(height: 12),
            _buildButton(context, '비밀번호 변경하기', reviewTargets),
            const SizedBox(height: 12),
            _buildButton(context, '리뷰 작성하기', reviewTargets),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSmallButton(context, '로그아웃'),
                _buildSmallButton(context, '탈퇴'),
              ],
            ),
            const Spacer(),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, List<ReviewTarget> reviewTargets) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          if (text == '리뷰 작성하기') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReviewListScreen(reviewTargets: reviewTargets),
              ),
            );
          } if (text == '비밀번호 변경하기') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
            );
          } if (text == '프로필 수정하기') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF6F1E9),
          foregroundColor: Colors.brown,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFB3926B)),
          ),
          elevation: 2,
        ),
        child: Center(
          child: Text(text, style: const TextStyle(fontSize: 14)),
        ),
      ),
    );
  }

  Widget _buildSmallButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        // TODO: 로그아웃 / 탈퇴 기능 구현 예정
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF6F1E9),
        foregroundColor: Colors.brown,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFFB3926B)),
        ),
        elevation: 2,
      ),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}
import 'package:flutter/material.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 60.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100.0,),
              // 앱 이름
              Text(
                'InfoTree',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF62462B),
                ),
              ),
              const SizedBox(height: 8),
              // 설명 텍스트
              Text(
                '학생 혜택 정보를 한눈에!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF876B55),
                ),
              ),
              const SizedBox(height: 48),

              // 이메일 입력
              TextFormField(
                decoration: InputDecoration(
                  hintText: '이메일',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF876B55),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xFF876B55),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xFF62462B),
                      width: 2.0,
                    )
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 비밀번호 입력
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF876B55),
                  ),
                  suffixIcon: const Icon(
                    Icons.visibility_off,
                    color: Color(0xFF876B55),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xFF876B55)
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color(0xFF62462B),
                      width: 2.0,
                    )
                  )
                ),
              ),
              const SizedBox(height: 30),

              // 로그인 버튼
              Center(
                child: SizedBox(
                  width: 230.0,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // 로그인 동작
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF377639),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 회원가입 텍스트 버튼
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return Color(0x99F6F1E9);
                          }
                        }
                    )
                  ),
                  child: const Text(
                    '계정이 없으신가요? 회원가입',
                    style: TextStyle(color: Color(0xFF876B55)),
                  ),
                ),
              ),

              // 관리자 로그인 버튼
              Center(
                child: TextButton(
                  onPressed: () {
                    // 관리자 웹 로그인 이동
                  },
                  style: ButtonStyle(
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.pressed)) {
                              return Color(0x99F6F1E9);
                            }
                          }
                      )
                  ),
                  child: const Text(
                    '구독 채널 관리자는 여기를 클릭',
                    style: TextStyle(color: Color(0xFF876B55)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
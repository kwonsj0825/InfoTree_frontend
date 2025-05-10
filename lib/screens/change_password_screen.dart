import 'package:flutter/material.dart';
import '../main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _errorText;

  void _submit() {
    final current = _currentPasswordController.text.trim();
    final newPw = _newPasswordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    setState(() {
      _errorText = null;
    });

    if (current != dummyUser.password) {
      setState(() => _errorText = '기존 비밀번호가 일치하지 않습니다.');
      return;
    }

    if (newPw.length < 6) {
      setState(() => _errorText = '비밀번호는 최소 6자 이상이어야 합니다.');
      return;
    }

    if (newPw != confirm) {
      setState(() => _errorText = '새 비밀번호가 일치하지 않습니다.');
      return;
    }

    // 실제 변경 처리
    dummyUser.password = newPw;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('비밀번호가 성공적으로 변경되었습니다!')),
    );

    Navigator.pop(context); // 마이페이지로 돌아감
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('비밀번호 변경', style: TextStyle(color: Color(0xFF62462B))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF62462B)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            _buildPasswordField('기존 비밀번호', _currentPasswordController),
            const SizedBox(height: 16),
            _buildPasswordField('새 비밀번호', _newPasswordController),
            const SizedBox(height: 16),
            _buildPasswordField('비밀번호 확인', _confirmPasswordController),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF377639),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('비밀번호 변경하기', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            hintText: '$label 입력',
            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF876B55)),
            suffixIcon: const Icon(Icons.visibility_off, color: Color(0xFF876B55)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFF876B55)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFF62462B), width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
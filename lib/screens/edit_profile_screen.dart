import 'package:flutter/material.dart';
import '../main.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController(text: dummyUser.school);
  final TextEditingController _majorController = TextEditingController(text: dummyUser.major.join(', '));

  String? _errorText;

  void _submit() {
    final pw = _passwordController.text.trim();
    final newSchool = _schoolController.text.trim();
    final newMajor = _majorController.text.trim();

    setState(() {
      _errorText = null;
    });

    if (pw != dummyUser.password) {
      setState(() => _errorText = '현재 비밀번호가 일치하지 않습니다.');
      return;
    }

    dummyUser.school = newSchool;
    dummyUser.major = newMajor.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('프로필이 성공적으로 수정되었습니다!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('프로필 수정하기', style: TextStyle(color: Color(0xFF62462B))),
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
            _buildTextField('현재 비밀번호', _passwordController, isPassword: true),
            const SizedBox(height: 16),
            _buildTextField('학교', _schoolController),
            const SizedBox(height: 16),
            _buildTextField('전공 (쉼표로 구분)', _majorController),
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
                child: const Text('수정 완료', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: '$label 입력',
            prefixIcon: Icon(
              isPassword ? Icons.lock_outline : Icons.school,
              color: const Color(0xFF876B55),
            ),
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
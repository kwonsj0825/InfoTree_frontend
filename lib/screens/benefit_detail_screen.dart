import 'package:flutter/material.dart';
import '../models/benefit.dart';

class BenefitDetailScreen extends StatelessWidget {
  final Benefit benefit;

  const BenefitDetailScreen({super.key, required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(benefit.title, style: const TextStyle(color: Color(0xFF62462B))),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF62462B)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (benefit.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(benefit.image!, height: 180, width: double.infinity, fit: BoxFit.cover),
              ),
            const SizedBox(height: 16),
            Text(benefit.description, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 12),
            Text('시작일: ${benefit.startDate.toLocal().toString().split(' ')[0]}'),
            Text('종료일: ${benefit.endDate.toLocal().toString().split(' ')[0]}'),
            if (benefit.link != null) ...[
              const SizedBox(height: 12),
              Text('자세히 보기: ${benefit.link}', style: const TextStyle(color: Colors.blue)),
            ],
          ],
        ),
      ),
    );
  }
}
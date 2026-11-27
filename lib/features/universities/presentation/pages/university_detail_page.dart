import 'package:flutter/material.dart';

class UniversityDetailPage extends StatelessWidget {
  const UniversityDetailPage({required this.universityId, super.key});

  final String universityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('University detail')),
      body: Center(child: Text('University id: $universityId')),
    );
  }
}

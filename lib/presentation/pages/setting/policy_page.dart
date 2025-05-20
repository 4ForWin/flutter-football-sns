import 'package:flutter/material.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('약관 및 개인정보 처리방침')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '이용약관 및 개인정보 처리방침.',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mercenaryhub/core/shared_prefs/shared_prefs.dart';
import 'package:mercenaryhub/presentation/pages/login/login_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // 3초 후에 다음 화면으로 이동
    Timer(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    final prefs = SharedPrefs.instance;
    final bool? isLogined = prefs.getBool('isLogined');
    try {
      if (user != null && isLogined!) {
        Navigator.pushNamedAndRemoveUntil(context, '/terms', (route) => false);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    } catch (e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(158, 215, 193, 1),
      body: const Center(
        child: Text(
          '용병모아',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w800,
            fontSize: 42,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

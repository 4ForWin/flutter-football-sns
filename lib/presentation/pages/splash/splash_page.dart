import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/core/shared_prefs/shared_prefs.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/home_bottom_navigation_bar_view_model.dart';
import 'package:mercenaryhub/presentation/pages/login/login_view.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
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
    final homeBottomVm =
        ref.read(homeBottomNavigationBarViewModelProvider.notifier);
    final bool agreedTerms = prefs.getBool('agreed_terms') ?? false;
    final int homeIndex = prefs.getInt('home_index') ?? 0;

    try {
      if (user != null) {
        if (agreedTerms) {
          homeBottomVm.onIndexChanged(homeIndex);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/terms', (route) => false);
        }
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

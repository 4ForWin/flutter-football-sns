import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mercenaryhub/presentation/view/login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    //3초후에 다음 화면으로 이동
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(158, 215, 193, 1),
        body: Center(
            child: Text(
          '용병모아',
          style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w800,
              fontSize: 32,
              color: Colors.white),
        )),
      ),
    );
  }
}

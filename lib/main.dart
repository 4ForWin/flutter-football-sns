import 'package:flutter/material.dart';
import 'package:mercenaryhub/presentation/view/splash/splash_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard'), //앱 기본 폰트 변경
      home: const Scaffold(
        body: Center(child: SplashView()),
      ),
    );
  }
}

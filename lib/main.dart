import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/pages/setting/setting_page.dart';
import 'package:mercenaryhub/presentation/pages/home/home_page.dart';
import 'package:mercenaryhub/presentation/pages/splash/splash_view.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mercenaryhub/presentation/pages/splash/splash_view.dart';
import 'package:mercenaryhub/presentation/pages/setting/setting_page.dart';
import 'package:mercenaryhub/presentation/pages/setting/alarm_setting_page.dart';
import 'package:mercenaryhub/presentation/pages/setting/policy_page.dart';
import 'package:mercenaryhub/presentation/pages/login/login_view.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard'),
      home: const SplashView(),
      routes: {
        '/setting': (context) => const SettingPage(),
        '/alarm_setting': (context) => const AlarmSettingPage(),
        // '/apply_history': (context) => const ApplyHistoryPage(), // 필요 시 추가
        '/policy': (context) => const PolicyPage(),
        '/login': (context) => const LoginView(),
      },
    );
  }
}

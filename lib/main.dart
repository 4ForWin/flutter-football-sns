
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/firebase_options.dart';
import 'package:mercenaryhub/presentation/pages/splash/splash_view.dart';
import 'package:mercenaryhub/presentation/pages/setting/setting_page.dart';
import 'package:mercenaryhub/presentation/pages/setting/alarm_setting_page.dart';
import 'package:mercenaryhub/presentation/pages/setting/policy_page.dart';
import 'package:mercenaryhub/presentation/pages/login/login_view.dart';
import 'package:mercenaryhub/presentation/pages/terms/widget/terms_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard'), // 앱 기본 폰트 변경
      home: const TermsOfServiceAgreement(),
      routes: {
        '/setting': (context) => const SettingPage(),
        '/alarm_setting': (context) => const AlarmSettingPage(),
        // '/apply_history': (context) => const ApplyHistoryPage(),
        '/policy': (context) => const PolicyPage(),
        '/login': (context) => const LoginView(),
      },
    );
  }
}
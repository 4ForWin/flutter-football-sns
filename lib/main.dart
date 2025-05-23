import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mercenaryhub/core/shared_prefs/shared_prefs.dart';
import 'package:mercenaryhub/firebase_options.dart';
import 'package:mercenaryhub/presentation/pages/home/home_page.dart';
import 'package:mercenaryhub/presentation/pages/splash/splash_view.dart';
import 'package:mercenaryhub/presentation/pages/setting/setting_page.dart';
import 'package:mercenaryhub/presentation/pages/setting/alarm_setting_page.dart';
import 'package:mercenaryhub/presentation/pages/setting/policy_page.dart';
import 'package:mercenaryhub/presentation/pages/login/login_view.dart';
import 'package:mercenaryhub/presentation/pages/terms/widget/terms_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPrefs.init(); // SharedPreferences 초기화
  await dotenv.load(fileName: ".env");
   KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY']); 
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard'), // 앱 기본 폰트 변경
      home: const SplashView(),
      routes: {
        '/setting': (context) => const SettingPage(),
        '/alarm_setting': (context) => const AlarmSettingPage(),
        '/terms' : (context) => const TermsOfServiceAgreement(),
        '/home': (context) => const HomePage(),
        '/policy': (context) => const PolicyPage(),
        '/login': (context) => const LoginView(),
      },

      //앱 자체 언어 설정 함으로써 캘린더를 한국어로 변경
      localizationsDelegates: [
        // 앱의 로컬라이제이션을 구성합니다.
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        // 앱에서 지원하는 언어 목록을 설정합니다.
        const Locale('ko', 'KR'), // 한국어
        const Locale('en', 'US'), // 영어
      ],
    );
  }
}

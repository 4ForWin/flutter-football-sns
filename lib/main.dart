import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    _listenToTokenRefresh(user.uid); // ✅ 앱 시작 시 리스너 등록
  }

  await SharedPrefs.init(); // SharedPreferences 초기화
  await dotenv.load(fileName: ".env");
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY']);
  runApp(const ProviderScope(child: MainApp()));
}

/// ✅ FCM 토큰 갱신 감지 및 Firestore 업데이트 함수
void _listenToTokenRefresh(String uid) {
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    debugPrint('🔁 새 FCM 토큰 감지: $newToken');

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'fcmToken': newToken,
      'updatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  });
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
        '/terms': (context) => const TermsOfServiceAgreement(),
        '/home': (context) => const HomePage(),
        '/policy': (context) => const PolicyPage(),
        '/login': (context) => const LoginView(),
      },

      // 캘린더, 날짜 등 한국어 로컬라이제이션 지원
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
    );
  }
}

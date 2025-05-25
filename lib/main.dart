import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mercenaryhub/core/notification_service/notification_service.dart';
import 'package:mercenaryhub/core/shared_prefs/shared_prefs.dart';
import 'package:mercenaryhub/firebase_options.dart';
import 'package:mercenaryhub/presentation/pages/home/home_page.dart';
import 'package:mercenaryhub/presentation/pages/intro/intro_level_page.dart';
import 'package:mercenaryhub/presentation/pages/mercenary_applicants/mercenary_applicants_page.dart';
import 'package:mercenaryhub/presentation/pages/splash/splash_view.dart';
import 'package:mercenaryhub/presentation/pages/setting/setting_page.dart';
import 'package:mercenaryhub/presentation/pages/setting/alarm_setting_page.dart';
import 'package:mercenaryhub/presentation/pages/team_apply_history/team_apply_history_page.dart';
import 'package:mercenaryhub/presentation/pages/mercenary_apply_history/mercenary_apply_history_page.dart';
import 'package:mercenaryhub/presentation/pages/login/login_view.dart';
import 'package:mercenaryhub/presentation/pages/team_invitation_history/team_invitation_history_page.dart';
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
  initLocalNotification(); // ✅ 알림 초기화
  FirebaseMessaging.onMessage.listen(showNotification); // ✅ 포그라운드 푸시 알림 표시
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard'), // 앱 기본 폰트 변경
      home: const SplashView(),
      // main.dart 파일의 routes 섹션에 다음 라우트를 추가해주세요

      routes: {
        '/setting': (context) => const SettingPage(),
        '/alarm_setting': (context) => const AlarmSettingPage(),
        '/team_apply_history': (context) => const TeamApplyHistoryPage(),
        '/mercenary_apply_history': (context) => const MercenaryApplyHistoryPage(),
        '/terms': (context) => const TermsOfServiceAgreement(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginView(),
        'level': (context) => IntroLevelPage(),  
        '/team_invitation_history': (context) => const TeamInvitationHistoryPage(),
        '/mercenary_applicants': (context) => const MercenaryApplicantsPage(), // 새로 추가
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

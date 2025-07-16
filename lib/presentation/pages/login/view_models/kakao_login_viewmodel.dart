import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/core/shared_prefs/shared_prefs.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/home_bottom_navigation_bar_view_model.dart';
import '../../../../domain/usecase/login_with_kakao.dart';

class KakaoLoginViewModel extends ChangeNotifier {
  final Ref ref;
  final LoginWithKakao loginUseCase;
  final prefs = SharedPrefs.instance;

  KakaoLoginViewModel(this.ref, this.loginUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user;
  User? get user => _user;

  Future<void> login(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await loginUseCase();
      _user = result;
      _isLoading = false;

      if (_user != null) {
        // ✅ 로그인 상태 저장
        prefs.setBool('isLogined', true);

        // ✅ FCM 권한 요청 및 토큰 수신
        await FirebaseMessaging.instance.requestPermission();
        final fcmToken = await FirebaseMessaging.instance.getToken();

        if (fcmToken != null) {
          await _saveFCMToken(_user!.uid, fcmToken);
        }
        // ✅ 홈으로 이동
        final bool agreedTerms = prefs.getBool('agreed_terms') ?? false;
        final int homeIndex = prefs.getInt('home_index') ?? 0;
        final homeBottomVm =
            ref.read(homeBottomNavigationBarViewModelProvider.notifier);
        if (agreedTerms) {
          homeBottomVm.onIndexChanged(homeIndex);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/terms', (route) => false);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ 로그인 실패')),
        );
      }
    } catch (e) {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ 예외 발생: $e')),
      );
    }

    notifyListeners();
  }

  /// Firestore에 FCM 토큰 저장
  Future<void> _saveFCMToken(String uid, String token) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'fcmToken': token,
      'updatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }
}

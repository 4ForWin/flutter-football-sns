import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/core/shared_prefs/shared_prefs.dart';
import '../../../../domain/usecases/login_with_kakao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KakaoLoginViewModel extends ChangeNotifier {
  final LoginWithKakao loginUseCase;
  final prefs = SharedPrefs.instance;
  KakaoLoginViewModel(this.loginUseCase);

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
        prefs.setBool('isLogined', true);
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
}

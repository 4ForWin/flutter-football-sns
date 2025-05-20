import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../domain/usecases/login_with_kakao.dart';

class KakaoLoginViewModel extends ChangeNotifier {
  final LoginWithKakao loginUseCase;

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
        debugPrint("✅ 카카오 로그인 성공");
        // TODO: 홈 화면으로 이동 처리 등 추가
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

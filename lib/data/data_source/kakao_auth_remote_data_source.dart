import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart'; // for Client, Uri.parse
import 'package:firebase_auth/firebase_auth.dart'; // for FirebaseAuth

class KakaoAuthRemoteDataSource {
  Future<String?> login() async {
    try {
      final provider = OAuthProvider("oidc.mercenaryhub");
      final token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오 로그인 성공: $token');

      // ✅ null 체크
      if (token.idToken == null || token.accessToken == null) {
        print("카카오 토큰 누락: idToken 또는 accessToken이 null입니다.");
        return "error";
      }

      final credential = provider.credential(
        idToken: token.idToken!,
        accessToken: token.accessToken!,
      );

      // ✅ Firebase 로그인 시도
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("Firebase 로그인 성공");
      return "success";

    } catch (e) {
      print('로그인 전체 실패: $e');
      return "error";
    }
  }
}

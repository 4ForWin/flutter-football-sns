import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mercenaryhub/core/social_login/social_login.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡 로그인 성공');
          return true;
        } catch (error) {
          print('카카오톡 로그인 실패: $error');

          if (error is PlatformException && error.code == 'CANCELED') {
            return false; // 사용자 취소
          }

          // 카카오톡 로그인 실패 시 카카오 계정으로 재시도
          try {
            await UserApi.instance.loginWithKakaoAccount();
            print('카카오 계정 로그인 성공');
            return true;
          } catch (e) {
            print('카카오 계정 로그인 실패: $e');
            return false;
          }
        }
      } else {
        // 카카오톡 미설치 시 카카오 계정 로그인 시도
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오 계정 로그인 성공');
        return true;
      }
    } catch (e) {
      print('로그인 전체 실패: $e');
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (_) {
      return false;
    }
  }
}

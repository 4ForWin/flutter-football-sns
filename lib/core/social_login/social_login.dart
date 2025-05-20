// lib/social_login/social_login.dart
abstract class SocialLogin {
  Future<bool> login();
  Future<bool> logout();
}

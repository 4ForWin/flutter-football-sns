import 'package:firebase_auth/firebase_auth.dart';

abstract class KakaoAuthRepository {
  Future<User?> login();
}

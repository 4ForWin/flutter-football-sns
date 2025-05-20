import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/kakao_auth_repository.dart';

class LoginWithKakao {
  final KakaoAuthRepository repository;

  LoginWithKakao(this.repository);

  Future<User?> call() {
    return repository.login();
  }
}

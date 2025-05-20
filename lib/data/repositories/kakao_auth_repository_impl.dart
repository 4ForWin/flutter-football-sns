import 'package:firebase_auth/firebase_auth.dart';
import '../../core/social_login/social_login.dart';
import '../datasources/kakao_auth_remote_data_source.dart';
import '../../domain/repositories/kakao_auth_repository.dart';

class KakaoAuthRepositoryImpl implements KakaoAuthRepository {
  final SocialLogin socialLogin;
  final KakaoAuthRemoteDataSource remoteDataSource;

  KakaoAuthRepositoryImpl(this.socialLogin, this.remoteDataSource);

  @override
  Future<User?> login() async {
    final isLoggedIn = await socialLogin.login();
    if (!isLoggedIn) return null;

    final result = await remoteDataSource.login();
    if (result == "success") {
      return FirebaseAuth.instance.currentUser;
    } else {
      return null;
    }
  }
}

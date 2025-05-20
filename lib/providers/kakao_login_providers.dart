import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../core/social_login/kakao_social_login.dart';
import '../core/social_login/social_login.dart';
import '../data/datasources/kakao_auth_remote_data_source.dart';
import '../data/repositories/kakao_auth_repository_impl.dart';
import '../domain/repositories/kakao_auth_repository.dart';
import '../domain/usecases/login_with_kakao.dart';
import '../presentation/pages/login/view_models/kakao_login_viewmodel.dart';

final kakaoLoginProvider = Provider<SocialLogin>((ref) => KakaoLogin());
final kakaoRemoteDataSourceProvider =
    Provider((ref) => KakaoAuthRemoteDataSource());
final kakaoAuthRepositoryProvider = Provider<KakaoAuthRepository>((ref) =>
    KakaoAuthRepositoryImpl(
        ref.read(kakaoLoginProvider), ref.read(kakaoRemoteDataSourceProvider)));
final loginWithKakaoUseCaseProvider =
    Provider((ref) => LoginWithKakao(ref.read(kakaoAuthRepositoryProvider)));
final kakaoLoginViewModelProvider = ChangeNotifierProvider(
    (ref) => KakaoLoginViewModel(ref.read(loginWithKakaoUseCaseProvider)));

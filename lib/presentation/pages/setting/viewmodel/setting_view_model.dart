import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:mercenaryhub/core/shared_prefs/shared_prefs.dart';

class SettingState {
  final bool isLoading;
  final kakao.User? kakaoUser;
  final String? errorMessage;

  const SettingState({
    this.isLoading = false,
    this.kakaoUser,
    this.errorMessage,
  });

  SettingState copyWith({
    bool? isLoading,
    kakao.User? kakaoUser,
    String? errorMessage,
  }) {
    return SettingState(
      isLoading: isLoading ?? this.isLoading,
      kakaoUser: kakaoUser ?? this.kakaoUser,
      errorMessage: errorMessage,
    );
  }
}

class SettingViewModel extends StateNotifier<SettingState> {
  SettingViewModel() : super(const SettingState()) {
    fetchKakaoUserInfo();
  }

  final List<Map<String, String>> _policyUrls = [
    {
      'title': '회원 이용약관',
      'url': 'https://www.notion.so/1fb94968b97380a9ac4fd33cdc6105c1?pvs=4'
    },
    {
      'title': '개인정보 수집/이용',
      'url': 'https://www.notion.so/1fb94968b973803d9664f58c5fa3d704?pvs=4'
    },
    {
      'title': '위치기반 서비스 이용약관',
      'url': 'https://www.notion.so/1fb94968b9738030a653ce33e9993baf?pvs=4'
    },
  ];

  /// 카카오 사용자 정보 가져오기
  Future<void> fetchKakaoUserInfo() async {
    state = state.copyWith(isLoading: true);

    try {
      final user = await kakao.UserApi.instance.me();
      state = state.copyWith(
        kakaoUser: user,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      print('❌ fetchKakaoUserInfo error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '사용자 정보를 불러올 수 없습니다.',
      );
    }
  }

  /// 알림 설정 페이지로 이동
  void navigateToAlarmSetting(BuildContext context) {
    Navigator.pushNamed(context, '/alarm_setting');
  }

  /// 내가 신청한 팀 페이지로 이동
  void navigateToTeamApplyHistory(BuildContext context) {
    Navigator.pushNamed(context, '/team_apply_history');
  }

  /// 나를 초대한 팀 페이지로 이동 (추가 예정)
  void navigateToTeamInvitationHistory(BuildContext context) {
    // TODO: 구현 예정
    Navigator.pushNamed(context, '/team_invitation_history');
  }

  /// 내가 초대한 용병 페이지로 이동
  void navigateToMercenaryApplyHistory(BuildContext context) {
    Navigator.pushNamed(context, '/mercenary_apply_history');
  }

  /// 팀에 지원한 용병 페이지로 이동 (추가 예정)
  void navigateToMercenaryApplicants(BuildContext context) {
    // TODO: 구현 예정
    Navigator.pushNamed(context, '/mercenary_applicants');
  }

  /// 이용약관 및 개인정보처리방침 보기
  Future<void> showPolicyLinks(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          '이용약관 및 개인정보 처리방침',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _policyUrls.map((policy) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                policy['title']!,
                style: const TextStyle(
                  color: Color(0xFF2BBB7D),
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
              onTap: () => _launchUrl(policy['url']!, context),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '닫기',
              style: TextStyle(color: Color(0xFF2BBB7D)),
            ),
          ),
        ],
      ),
    );
  }

  /// 앱 버전 정보 보기
  void showAppVersion(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          '버전정보',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          '현재 버전: ver.1.0.0',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '확인',
              style: TextStyle(color: Color(0xFF2BBB7D)),
            ),
          ),
        ],
      ),
    );
  }

  /// URL 열기
  Future<void> _launchUrl(String url, BuildContext context) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('링크를 열 수 없습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 로그아웃 처리
  Future<bool> _performLogout() async {
    try {
      // 1. 카카오 로그아웃
      await kakao.UserApi.instance.logout();
      print('✅ 카카오 로그아웃 성공');

      // 2. Firebase 로그아웃
      await firebase.FirebaseAuth.instance.signOut();
      print('✅ Firebase 로그아웃 성공');

      // 3. SharedPreferences 로그인 상태 제거
      final prefs = SharedPrefs.instance;
      await prefs.remove('isLogined');
      print('✅ SharedPreferences 로그인 상태 제거 성공');

      return true;
    } catch (e) {
      print('❌ 로그아웃 실패: $e');
      return false;
    }
  }

  /// 로그아웃 버튼 클릭 처리
  Future<void> onLogoutPressed(BuildContext context) async {
    final confirmed = await _showLogoutConfirmDialog(context);

    if (confirmed == true) {
      state = state.copyWith(isLoading: true);

      final success = await _performLogout();

      state = state.copyWith(isLoading: false);

      if (success && context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그아웃에 실패했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 로그아웃 확인 다이얼로그
  Future<bool?> _showLogoutConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          '로그아웃',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          '정말 로그아웃 하시겠습니까?',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              '취소',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              '확인',
              style: TextStyle(color: Color(0xFF2BBB7D)),
            ),
          ),
        ],
      ),
    );
  }
}

final settingViewModelProvider =
    StateNotifierProvider<SettingViewModel, SettingState>(
  (ref) => SettingViewModel(),
);

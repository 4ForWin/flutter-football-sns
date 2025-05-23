import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget/profile_section.dart';
import 'widget/setting_tile.dart';
import 'viewmodel/setting_view_model.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(settingViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
        title: const Text('설정'),
      ),
      body: ListView(
        children: [
          const ProfileSection(),
          const Divider(height: 1, color: Color(0xFFE8EEF2)),

          // 기본 설정 항목들
          SettingTile(
            title: '팀 신청내역',
            onTap: () => viewModel.navigateToTeamApplyHistory(context),
          ),
          SettingTile(
            title: '용병 신청내역',
            onTap: () => viewModel.navigateToMercenaryApplyHistory(context),
          ),
          SettingTile(
            title: '알림 설정',
            onTap: () => viewModel.navigateToAlarmSetting(context),
          ),
          SettingTile(
            title: '이용약관 및 개인정보 처리방침',
            onTap: () => viewModel.showPolicyLinks(context),
          ),
          SettingTile(
            title: '버전정보',
            onTap: () => viewModel.showAppVersion(context),
          ),

          // 구분선
          const Divider(height: 1, color: Color(0xFFE8EEF2)),

          // 로그아웃
          SettingTile(
            title: '로그아웃',
            onTap: () => viewModel.onLogoutPressed(context),
          ),
        ],
      ),
    );
  }
}

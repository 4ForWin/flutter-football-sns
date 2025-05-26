import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget/profile_section.dart';
import 'widget/setting_tile.dart';
import 'viewmodel/setting_view_model.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(settingViewModelProvider.notifier);

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

          // 신청/초대 관리 섹션
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: const Text(
              '신청/초대 관리',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF757B80),
              ),
            ),
          ),

          SettingTile(
            title: '내가 신청한 팀',
            subtitle: '팀에 지원한 내역 (취소만 가능)',
            icon: Icons.send,
            onTap: () => viewModel.navigateToTeamApplyHistory(context),
          ),
          SettingTile(
            title: '나를 초대한 팀',
            subtitle: '팀에서 받은 초대 (수락/거절 가능)',
            icon: Icons.inbox,
            onTap: () => viewModel.navigateToTeamInvitationHistory(context),
          ),
          SettingTile(
            title: '내가 초대한 용병',
            subtitle: '용병에게 보낸 초대 (취소만 가능)',
            icon: Icons.person_add,
            onTap: () => viewModel.navigateToMercenaryApplyHistory(context),
          ),
          SettingTile(
            title: '팀에 지원한 용병',
            subtitle: '용병 지원자 관리 (수락/거절 가능)',
            icon: Icons.people,
            onTap: () => viewModel.navigateToMercenaryApplicants(context),
          ),

          const Divider(height: 1, color: Color(0xFFE8EEF2)),

          // 일반 설정 섹션
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: const Text(
              '일반 설정',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF757B80),
              ),
            ),
          ),

          SettingTile(
            title: '알림 설정',
            icon: Icons.notifications,
            onTap: () => viewModel.navigateToAlarmSetting(context),
          ),
          SettingTile(
            title: '이용약관 및 개인정보 처리방침',
            icon: Icons.description,
            onTap: () => viewModel.showPolicyLinks(context),
          ),
          SettingTile(
            title: '버전정보',
            icon: Icons.info,
            onTap: () => viewModel.showAppVersion(context),
          ),

          // 구분선
          const Divider(height: 1, color: Color(0xFFE8EEF2)),

          // 계정 관리 섹션
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: const Text(
              '계정 관리',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF757B80),
              ),
            ),
          ),

          SettingTile(
            title: '로그아웃',
            icon: Icons.logout,
            onTap: () => viewModel.onLogoutPressed(context),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/domain/entity/team_invitation_received.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class TeamInvitationHistoryViewModel
    extends AsyncNotifier<List<TeamInvitationReceived>> {
  @override
  Future<List<TeamInvitationReceived>> build() async {
    return await fetchTeamInvitations();
  }

  Future<List<TeamInvitationReceived>> fetchTeamInvitations() async {
    try {
      print('😇 TeamInvitationHistoryViewModel: fetchTeamInvitations 시작');

      // 현재 로그인된 사용자 확인
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return [];
      }

      // 약간의 딜레이 (로딩 시뮬레이션)
      await Future.delayed(const Duration(milliseconds: 500));

      final fetchTeamInvitationsUsecase =
          ref.read(fetchTeamInvitationsUsecaseProvider);

      print('🚓 UseCase 호출 중...');
      final teamInvitations = await fetchTeamInvitationsUsecase.execute();

      print('✅ ${teamInvitations.length}개의 팀 초대 내역을 불러왔습니다.');

      // 최신순으로 정렬 (초대받은 날짜 기준)
      teamInvitations.sort((a, b) => b.receivedAt.compareTo(a.receivedAt));

      return teamInvitations;
    } catch (e, stackTrace) {
      print('❌ fetchTeamInvitations 에러: $e');
      print('❌ Stack trace: $stackTrace');
      return [];
    }
  }

  /// 팀 초대 내역 새로고침
  Future<void> refreshTeamInvitations() async {
    try {
      print('🔄 팀 초대 내역 새로고침 시작');
      state = const AsyncValue.loading();

      final refreshedInvitations = await fetchTeamInvitations();
      state = AsyncValue.data(refreshedInvitations);

      print('✅ 팀 초대 내역 새로고침 완료');
    } catch (e, stackTrace) {
      print('❌ 새로고침 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 팀 초대에 응답 (수락/거절)
  Future<void> respondToInvitation(String feedId, String response) async {
    try {
      print('🔄 팀 초대 응답 시작: $feedId -> $response');

      // 현재 상태를 로딩으로 변경
      state = const AsyncValue.loading();

      final respondToTeamInvitationUsecase =
          ref.read(respondToTeamInvitationUsecaseProvider);

      final success = await respondToTeamInvitationUsecase.execute(
        feedId: feedId,
        response: response,
      );

      if (success) {
        print('✅ 팀 초대 응답 성공');
        // 응답 후 목록 새로고침
        await refreshTeamInvitations();
      } else {
        print('❌ 팀 초대 응답 실패');
        state = AsyncValue.error(
          '응답 처리에 실패했습니다',
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      print('❌ respondToInvitation 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 팀 초대 수락 (편의 메서드)
  Future<void> acceptInvitation(String feedId) async {
    await respondToInvitation(feedId, 'accepted');
  }

  /// 팀 초대 거절 (편의 메서드)
  Future<void> rejectInvitation(String feedId) async {
    await respondToInvitation(feedId, 'rejected');
  }

  /// 특정 초대 내역 상세 정보 가져오기
  TeamInvitationReceived? getInvitationById(String feedId) {
    final currentState = state.value;
    if (currentState == null) return null;

    try {
      return currentState
          .firstWhere((invitation) => invitation.feedId == feedId);
    } catch (e) {
      print('❌ 초대 내역을 찾을 수 없습니다: $feedId');
      return null;
    }
  }
}

final teamInvitationHistoryViewModelProvider = AsyncNotifierProvider<
    TeamInvitationHistoryViewModel, List<TeamInvitationReceived>>(
  () => TeamInvitationHistoryViewModel(),
);

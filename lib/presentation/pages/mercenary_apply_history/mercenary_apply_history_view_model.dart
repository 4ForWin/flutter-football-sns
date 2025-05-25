import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/domain/entity/my_mercenary_invitation_history.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';
import 'package:mercenaryhub/core/services/application_status_service.dart';

class MyMercenaryInvitationHistoryViewModel
    extends AsyncNotifier<List<MyMercenaryInvitationHistory>> {
  @override
  Future<List<MyMercenaryInvitationHistory>> build() async {
    return await fetchInvitationHistories();
  }

  Future<List<MyMercenaryInvitationHistory>> fetchInvitationHistories() async {
    try {
      print(
          '😇 MercenaryInvitationHistoryViewModel: fetchInvitationHistories 시작');

      // 현재 로그인된 사용자 확인
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return [];
      }

      // 약간의 딜레이 (로딩 시뮬레이션)
      await Future.delayed(const Duration(milliseconds: 500));

      final fetchInvitationHistoriesUsecase =
          ref.read(fetchInvitationHistoriesUsecaseProvider);

      print('🚓 UseCase 호출 중...');
      final invitationHistories =
          await fetchInvitationHistoriesUsecase.execute();

      print('✅ ${invitationHistories.length}개의 용병 초대 내역을 불러왔습니다.');

      // 최신순으로 정렬 (초대일 기준)
      invitationHistories.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));

      return invitationHistories;
    } catch (e, stackTrace) {
      print('❌ fetchInvitationHistories 에러: $e');
      print('❌ Stack trace: $stackTrace');
      return [];
    }
  }

  /// 초대 내역 새로고침
  Future<void> refreshInvitationHistories() async {
    try {
      print('🔄 용병 초대 내역 새로고침 시작');
      state = const AsyncValue.loading();

      final refreshedHistories = await fetchInvitationHistories();
      state = AsyncValue.data(refreshedHistories);

      print('✅ 용병 초대 내역 새로고침 완료');
    } catch (e, stackTrace) {
      print('❌ 새로고침 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 초대 상태 업데이트 (초대 취소)
  Future<void> updateInvitationStatus(String feedId, String status) async {
    try {
      print('🔄 초대 상태 업데이트 시작: $feedId -> $status');

      // 현재 상태를 로딩으로 변경
      state = const AsyncValue.loading();

      // 새로운 상태 업데이트 서비스 사용
      final success =
          await ApplicationStatusService.updateMercenaryInvitationStatus(
        feedId: feedId,
        newStatus: status,
      );

      if (success) {
        print('✅ 초대 상태 업데이트 성공');
        // 상태 업데이트 후 목록 새로고침
        await refreshInvitationHistories();
      } else {
        print('❌ 초대 상태 업데이트 실패');
        state = AsyncValue.error(
          '상태 업데이트에 실패했습니다',
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      print('❌ updateInvitationStatus 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 초대 취소 (편의 메서드)
  Future<void> cancelInvitation(String feedId) async {
    await updateInvitationStatus(feedId, 'cancelled');
  }

  /// 특정 초대 내역 상세 정보 가져오기
  MyMercenaryInvitationHistory? getInvitationById(String feedId) {
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

final myMercenaryInvitationHistoryViewModelProvider = AsyncNotifierProvider<
    MyMercenaryInvitationHistoryViewModel, List<MyMercenaryInvitationHistory>>(
  () => MyMercenaryInvitationHistoryViewModel(),
);

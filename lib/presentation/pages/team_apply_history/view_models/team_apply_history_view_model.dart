import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';
import 'package:mercenaryhub/providers/feed_providers.dart';
import 'package:mercenaryhub/core/services/application_status_service.dart';

class TeamApplyHistoryViewModel
    extends AsyncNotifier<List<MyTeamApplicationHistory>> {
  @override
  Future<List<MyTeamApplicationHistory>> build() async {
    return await fetchApplicationHistories();
  }

  Future<List<MyTeamApplicationHistory>> fetchApplicationHistories() async {
    try {
      print('😇 TeamApplyHistoryViewModel: fetchApplicationHistories 시작');

      // 현재 로그인된 사용자 확인
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return [];
      }

      // 약간의 딜레이 (로딩 시뮬레이션)
      await Future.delayed(const Duration(milliseconds: 500));

      final fetchApplicationHistoriesUsecase =
          ref.read(fetchApplicationHistoriesUsecaseProvider);

      print('🚓 UseCase 호출 중...');
      final applicationHistories =
          await fetchApplicationHistoriesUsecase.execute();

      print('✅ ${applicationHistories.length}개의 팀 신청 내역을 불러왔습니다.');

      // 최신순으로 정렬 (신청일 기준)
      applicationHistories.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));

      return applicationHistories;
    } catch (e, stackTrace) {
      print('❌ fetchApplicationHistories 에러: $e');
      print('❌ Stack trace: $stackTrace');
      return [];
    }
  }

  /// 신청 내역 새로고침
  Future<void> refreshApplicationHistories() async {
    try {
      print('🔄 팀 신청 내역 새로고침 시작');
      state = const AsyncValue.loading();

      final refreshedHistories = await fetchApplicationHistories();
      state = AsyncValue.data(refreshedHistories);

      print('✅ 팀 신청 내역 새로고침 완료');
    } catch (e, stackTrace) {
      print('❌ 새로고침 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 신청 상태 업데이트 (신청 취소)
  Future<void> updateStatus(String feedId, String status) async {
    try {
      print('🔄 신청 상태 업데이트 시작: $feedId -> $status');

      // 현재 상태를 로딩으로 변경
      state = const AsyncValue.loading();

      // 새로운 상태 업데이트 서비스 사용
      final success =
          await ApplicationStatusService.updateTeamApplicationStatus(
        feedId: feedId,
        newStatus: status,
      );

      if (success) {
        print('✅ 상태 업데이트 성공');
        // 상태 업데이트 후 목록 새로고침
        await refreshApplicationHistories();
      } else {
        print('❌ 상태 업데이트 실패');
        state = AsyncValue.error(
          '상태 업데이트에 실패했습니다',
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      print('❌ updateStatus 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final teamApplyHistoryViewModelProvider = AsyncNotifierProvider<
    TeamApplyHistoryViewModel, List<MyTeamApplicationHistory>>(
  () => TeamApplyHistoryViewModel(),
);

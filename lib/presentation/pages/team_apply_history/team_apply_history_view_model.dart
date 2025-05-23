import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/domain/entity/team_apply_history.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class TeamApplyHistoryViewModel extends AsyncNotifier<List<TeamApplyHistory>> {
  @override
  Future<List<TeamApplyHistory>> build() async {
    return await fetchTeamApplyHistories();
  }

  Future<List<TeamApplyHistory>> fetchTeamApplyHistories() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 로딩 시뮬레이션

    return [
      TeamApplyHistory(
        id: 'dummy1',
        teamName: 'FC 더미팀',
        mercenaryUserId: 'user123',
        mercenaryName: '홍길동',
        mercenaryProfileImage: 'https://via.placeholder.com/150',
        feedId: 'feed1',
        appliedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: 'pending',
        location: '서울 마포구',
        gameDate: DateTime.now().add(const Duration(days: 3)),
        gameTime: '18:00',
        level: '중급',
      ),
      TeamApplyHistory(
        id: 'dummy2',
        teamName: '서울유나이티드',
        mercenaryUserId: 'user456',
        mercenaryName: '김철수',
        mercenaryProfileImage: 'https://via.placeholder.com/150',
        feedId: 'feed2',
        appliedAt: DateTime.now().subtract(const Duration(days: 2)),
        status: 'accepted',
        location: '서울 강남구',
        gameDate: DateTime.now().add(const Duration(days: 5)),
        gameTime: '20:00',
        level: '상급',
      ),
    ];
  }

  // Future<List<TeamApplyHistory>> fetchTeamApplyHistories() async {
  //   final fetchUsecase = ref.read(fetchTeamApplyHistoriesUsecaseProvider);

  //   // TODO: 실제 팀 ID를 가져오는 로직 필요
  //   // 현재는 임시로 사용자 UID를 사용
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) {
  //     throw Exception('로그인이 필요합니다');
  //   }

  //   return await fetchUsecase.execute(user.uid);
  // }

  Future<void> updateStatus(String applyHistoryId, String status) async {
    final updateUsecase = ref.read(updateTeamApplyStatusUsecaseProvider);

    state = const AsyncValue.loading();

    try {
      final success = await updateUsecase.execute(
        applyHistoryId: applyHistoryId,
        status: status,
      );

      if (success) {
        // 상태 업데이트 후 목록 새로고침
        state = await AsyncValue.guard(() => fetchTeamApplyHistories());
      } else {
        state = AsyncValue.error(
          '상태 업데이트에 실패했습니다',
          StackTrace.current,
        );
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final teamApplyHistoryViewModelProvider =
    AsyncNotifierProvider<TeamApplyHistoryViewModel, List<TeamApplyHistory>>(
  () => TeamApplyHistoryViewModel(),
);

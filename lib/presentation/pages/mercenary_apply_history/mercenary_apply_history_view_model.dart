import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/domain/entity/mercenary_apply_history.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class MercenaryApplyHistoryViewModel
    extends AsyncNotifier<List<MercenaryApplyHistory>> {
  @override
  Future<List<MercenaryApplyHistory>> build() async {
    return await fetchMercenaryApplyHistories();
  }

  Future<List<MercenaryApplyHistory>> fetchMercenaryApplyHistories() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 로딩 시뮬레이션

    return [
      MercenaryApplyHistory(
        id: 'dummy-apply-1',
        userId: 'mercenary123',
        teamId: 'team456',
        teamName: 'FC 용병모집단',
        teamProfileImage: 'https://via.placeholder.com/150',
        feedId: 'feed789',
        appliedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: 'pending',
        location: '서울 송파구',
        gameDate: DateTime.now().add(const Duration(days: 2)),
        gameTime: '19:30',
        cost: '30000',
        level: '중급',
      ),
    ];
  }

  // Future<List<MercenaryApplyHistory>> fetchMercenaryApplyHistories() async {
  //   final fetchUsecase = ref.read(fetchMercenaryApplyHistoriesUsecaseProvider);

  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) {
  //     throw Exception('로그인이 필요합니다');
  //   }

  //   return await fetchUsecase.execute(user.uid);
  // }

  Future<void> cancelApply(String applyHistoryId) async {
    final cancelUsecase = ref.read(cancelMercenaryApplyUsecaseProvider);

    state = const AsyncValue.loading();

    try {
      final success = await cancelUsecase.execute(applyHistoryId);

      if (success) {
        // 취소 후 목록 새로고침
        state = await AsyncValue.guard(() => fetchMercenaryApplyHistories());
      } else {
        state = AsyncValue.error(
          '신청 취소에 실패했습니다',
          StackTrace.current,
        );
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final mercenaryApplyHistoryViewModelProvider = AsyncNotifierProvider<
    MercenaryApplyHistoryViewModel, List<MercenaryApplyHistory>>(
  () => MercenaryApplyHistoryViewModel(),
);

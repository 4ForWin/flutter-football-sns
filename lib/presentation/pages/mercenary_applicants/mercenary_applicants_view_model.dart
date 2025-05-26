import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/domain/entity/team_apply_history.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class MercenaryApplicantsViewModel
    extends AsyncNotifier<List<TeamApplyHistory>> {
  @override
  Future<List<TeamApplyHistory>> build() async {
    return await fetchMercenaryApplicants();
  }

  Future<List<TeamApplyHistory>> fetchMercenaryApplicants() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return [];
      }

      await Future.delayed(const Duration(milliseconds: 500));

      final fetchTeamApplyHistoriesUsecase =
          ref.read(fetchTeamApplyHistoriesUsecaseProvider);

      final applicants =
          await fetchTeamApplyHistoriesUsecase.execute(currentUser.uid);

      // 최신순으로 정렬 (지원일 기준)
      applicants.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));

      return applicants;
    } catch (e, stackTrace) {
      return [];
    }
  }

  /// 지원자 목록 새로고침
  Future<void> refreshMercenaryApplicants() async {
    try {
      state = const AsyncValue.loading();

      final refreshedApplicants = await fetchMercenaryApplicants();
      state = AsyncValue.data(refreshedApplicants);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 지원자 수락
  Future<void> acceptApplicant(String applicantId) async {
    try {
      state = const AsyncValue.loading();

      final updateTeamApplyStatusUsecase =
          ref.read(updateTeamApplyStatusUsecaseProvider);

      final success = await updateTeamApplyStatusUsecase.execute(
        applyHistoryId: applicantId,
        status: 'accepted',
      );

      if (success) {
        await refreshMercenaryApplicants();
      } else {
        state = AsyncValue.error('수락 처리에 실패했습니다', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 지원자 거절
  Future<void> rejectApplicant(String applicantId) async {
    try {
      state = const AsyncValue.loading();

      final updateTeamApplyStatusUsecase =
          ref.read(updateTeamApplyStatusUsecaseProvider);

      final success = await updateTeamApplyStatusUsecase.execute(
        applyHistoryId: applicantId,
        status: 'rejected',
      );

      if (success) {
        await refreshMercenaryApplicants();
      } else {
        state = AsyncValue.error('거절 처리에 실패했습니다', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 특정 지원자 상세 정보 가져오기
  TeamApplyHistory? getApplicantById(String applicantId) {
    final currentState = state.value;
    if (currentState == null) return null;

    try {
      return currentState
          .firstWhere((applicant) => applicant.id == applicantId);
    } catch (e) {
      return null;
    }
  }
}

final mercenaryApplicantsViewModelProvider =
    AsyncNotifierProvider<MercenaryApplicantsViewModel, List<TeamApplyHistory>>(
  () => MercenaryApplicantsViewModel(),
);

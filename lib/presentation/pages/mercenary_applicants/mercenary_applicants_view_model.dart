import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/domain/entity/mercenary_applicant.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';
import 'package:mercenaryhub/data/data_source/mercenary_applicants_data_source_impl.dart';
import 'package:mercenaryhub/data/repository/mercenary_applicants_repository_impl.dart';

// providers.dart의 private provider 직접 참조
final _mercenaryApplicantsRepositoryProvider = Provider((ref) {
  final dataSource =
      MercenaryApplicantsDataSourceImpl(FirebaseFirestore.instance);
  return MercenaryApplicantsRepositoryImpl(dataSource);
});

class MercenaryApplicantsViewModel
    extends AsyncNotifier<List<MercenaryApplicant>> {
  @override
  Future<List<MercenaryApplicant>> build() async {
    return await fetchMercenaryApplicants();
  }

  Future<List<MercenaryApplicant>> fetchMercenaryApplicants() async {
    try {
      print('😇 ViewModel: fetchMercenaryApplicants 시작');

      // 현재 로그인된 사용자 확인
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return [];
      }

      // 약간의 딜레이 (로딩 시뮬레이션)
      await Future.delayed(const Duration(milliseconds: 500));

      final fetchMercenaryApplicantsUsecase =
          ref.read(fetchMercenaryApplicantsUsecaseProvider);

      print('🚓 UseCase 호출 중...');
      final applicants =
          await fetchMercenaryApplicantsUsecase.execute(currentUser.uid);

      print('✅ ${applicants.length}개의 용병 지원자를 불러왔습니다.');

      // 최신순으로 정렬 (지원일 기준)
      applicants.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));

      return applicants;
    } catch (e, stackTrace) {
      print('❌ fetchMercenaryApplicants 에러: $e');
      print('❌ Stack trace: $stackTrace');
      return [];
    }
  }

  /// 용병 지원자 목록 새로고침
  Future<void> refreshMercenaryApplicants() async {
    try {
      print('🔄 용병 지원자 목록 새로고침 시작');
      state = const AsyncValue.loading();

      final refreshedApplicants = await fetchMercenaryApplicants();
      state = AsyncValue.data(refreshedApplicants);

      print('✅ 용병 지원자 목록 새로고침 완료');
    } catch (e, stackTrace) {
      print('❌ 새로고침 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 지원에 대한 응답 (수락/거절)
  Future<void> respondToApplication(
      String applicationId, String response) async {
    try {
      print('🔄 지원 응답 시작: $applicationId -> $response');

      // 현재 상태를 로딩으로 변경
      state = const AsyncValue.loading();

      final respondToMercenaryApplicationUsecase =
          ref.read(respondToMercenaryApplicationUsecaseProvider);

      final success = await respondToMercenaryApplicationUsecase.execute(
        applicationId: applicationId,
        response: response,
      );

      if (success) {
        print('✅ 지원 응답 성공');
        // 응답 후 목록 새로고침
        await refreshMercenaryApplicants();
      } else {
        print('❌ 지원 응답 실패');
        state = AsyncValue.error(
          '응답 처리에 실패했습니다',
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      print('❌ respondToApplication 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 지원 수락 (편의 메서드)
  Future<void> acceptApplication(String applicationId) async {
    await respondToApplication(applicationId, 'accepted');
  }

  /// 지원 거절 (편의 메서드)
  Future<void> rejectApplication(String applicationId) async {
    await respondToApplication(applicationId, 'rejected');
  }

  /// 특정 지원자 상세 정보 가져오기
  MercenaryApplicant? getApplicantById(String applicationId) {
    final currentState = state.value;
    if (currentState == null) return null;

    try {
      return currentState
          .firstWhere((applicant) => applicant.applicationId == applicationId);
    } catch (e) {
      print('❌ 지원자를 찾을 수 없습니다: $applicationId');
      return null;
    }
  }

  /// 대기중인 지원자 수 조회
  Future<int> getPendingApplicationCount() async {
    try {
      final fetchMercenaryApplicantsUsecase =
          ref.read(fetchMercenaryApplicantsUsecaseProvider);

      final count = await fetchMercenaryApplicantsUsecase.getPendingCount();
      print('📊 대기중인 지원자 수: $count명');

      return count;
    } catch (e) {
      print('❌ getPendingApplicationCount 에러: $e');
      return 0;
    }
  }

  /// 지원 통계 조회
  Future<Map<String, int>> getApplicationStatistics() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return {'total': 0, 'pending': 0, 'accepted': 0, 'rejected': 0};
      }

      // providers.dart에 정의된 private provider 사용
      final repository = ref.read(_mercenaryApplicantsRepositoryProvider);
      final statistics =
          await repository.getTeamApplicationStatistics(currentUser.uid);

      print('📊 지원 통계: ${statistics.toString()}');
      return statistics;
    } catch (e) {
      print('❌ getApplicationStatistics 에러: $e');
      return {'total': 0, 'pending': 0, 'accepted': 0, 'rejected': 0};
    }
  }

  /// 대량 응답 처리 (여러 지원자를 한 번에 수락/거절)
  Future<void> respondToMultipleApplications({
    required List<String> applicationIds,
    required String response,
  }) async {
    try {
      print('🔄 대량 응답 처리 시작: ${applicationIds.length}개 -> $response');

      state = const AsyncValue.loading();

      int successCount = 0;
      for (final applicationId in applicationIds) {
        final respondToMercenaryApplicationUsecase =
            ref.read(respondToMercenaryApplicationUsecaseProvider);

        final success = await respondToMercenaryApplicationUsecase.execute(
          applicationId: applicationId,
          response: response,
        );

        if (success) {
          successCount++;
        }
      }

      print('✅ 대량 응답 완료: $successCount/${applicationIds.length}개 성공');

      // 처리 후 목록 새로고침
      await refreshMercenaryApplicants();
    } catch (e, stackTrace) {
      print('❌ respondToMultipleApplications 에러: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 상태별 지원자 필터링
  List<MercenaryApplicant> getApplicantsByStatus(String status) {
    final currentState = state.value;
    if (currentState == null) return [];

    return currentState
        .where((applicant) => applicant.status == status)
        .toList();
  }

  /// 대기중인 지원자만 필터링
  List<MercenaryApplicant> getPendingApplicants() {
    return getApplicantsByStatus('pending');
  }

  /// 수락된 지원자만 필터링
  List<MercenaryApplicant> getAcceptedApplicants() {
    return getApplicantsByStatus('accepted');
  }

  /// 거절된 지원자만 필터링
  List<MercenaryApplicant> getRejectedApplicants() {
    return getApplicantsByStatus('rejected');
  }
}

final mercenaryApplicantsViewModelProvider = AsyncNotifierProvider<
    MercenaryApplicantsViewModel, List<MercenaryApplicant>>(
  () => MercenaryApplicantsViewModel(),
);

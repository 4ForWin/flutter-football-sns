import 'package:mercenaryhub/domain/entity/mercenary_applicant.dart';
import 'package:mercenaryhub/domain/repository/mercenary_applicants_repository.dart';

class FetchMercenaryApplicantsUsecase {
  final MercenaryApplicantsRepository _repository;

  FetchMercenaryApplicantsUsecase(this._repository);

  /// 현재 팀에 지원한 용병 목록 조회
  /// [teamUid] 사용자 ID
  Future<List<MercenaryApplicant>> execute(String teamUid) async {
    try {
      print('🚗 UseCase: fetchMercenaryApplicants 실행 - teamUid: $teamUid');

      final applicants = await _repository.fetchMercenaryApplicants(teamUid);

      print('✅ UseCase: ${applicants.length}개의 지원자 조회 완료');

      // 최신순 정렬 (지원일 기준)
      applicants.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));

      return applicants;
    } catch (e) {
      print('❌ FetchMercenaryApplicantsUsecase error: $e');
      return [];
    }
  }

  /// 특정 지원 내역 상세 조회
  /// [applicationId] 지원 ID
  Future<MercenaryApplicant?> fetchById(String applicationId) async {
    try {
      print(
          '🚗 UseCase: fetchMercenaryApplicantById 실행 - applicationId: $applicationId');

      final applicant =
          await _repository.fetchMercenaryApplicantById(applicationId);

      if (applicant != null) {
        print('✅ UseCase: 지원자 상세 정보 조회 완료 - ${applicant.mercenaryName}');
      } else {
        print('⚠️ UseCase: 지원자를 찾을 수 없음 - applicationId: $applicationId');
      }

      return applicant;
    } catch (e) {
      print('❌ FetchMercenaryApplicantsUsecase fetchById error: $e');
      return null;
    }
  }

  /// 대기중인 지원 수 조회 (알림 배지용)
  Future<int> getPendingCount() async {
    try {
      print('🚗 UseCase: getPendingApplicationCount 실행');

      final count = await _repository.getPendingApplicationCount();

      print('✅ UseCase: 대기중인 지원 수 - $count개');

      return count;
    } catch (e) {
      print('❌ FetchMercenaryApplicantsUsecase getPendingCount error: $e');
      return 0;
    }
  }

  /// 특정 팀 피드의 지원자 수 조회
  /// [teamFeedId] 팀 피드 ID
  Future<int> getApplicantCount(String teamFeedId) async {
    try {
      print('🚗 UseCase: getApplicantCount 실행 - teamFeedId: $teamFeedId');

      final count = await _repository.getApplicantCount(teamFeedId);

      print('✅ UseCase: 팀 피드 지원자 수 - $count개');

      return count;
    } catch (e) {
      print('❌ FetchMercenaryApplicantsUsecase getApplicantCount error: $e');
      return 0;
    }
  }
}

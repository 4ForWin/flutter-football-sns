import 'package:mercenaryhub/domain/entity/mercenary_applicant.dart';

abstract interface class MercenaryApplicantsRepository {
  /// 특정 팀에 지원한 용병 목록 조회
  /// [teamUid] 사용자 ID
  Future<List<MercenaryApplicant>> fetchMercenaryApplicants(String teamUid);

  /// 용병 지원에 대한 응답 (수락/거절)
  /// [applicationId] 지원 ID
  /// [response] 'accepted' 또는 'rejected'
  Future<bool> respondToMercenaryApplication({
    required String applicationId,
    required String response,
  });

  /// 특정 지원 내역 상세 조회
  /// [applicationId] 지원 ID
  Future<MercenaryApplicant?> fetchMercenaryApplicantById(String applicationId);

  /// 지원 상태 업데이트 (일반적인 상태 변경용)
  /// [applicationId] 지원 ID
  /// [newStatus] 새로운 상태
  Future<bool> updateApplicationStatus({
    required String applicationId,
    required String newStatus,
  });

  /// 현재 사용자가 등록한 팀 피드들의 ID 목록 조회
  /// 해당 팀 피드들에 지원한 용병들을 조회하기 위함
  Future<List<String>> fetchMyTeamFeedIds();

  /// 특정 팀 피드에 지원한 용병 수 조회
  /// [teamFeedId] 팀 피드 ID
  Future<int> getApplicantCount(String teamFeedId);

  /// 대기중인 지원 수 조회 (알림 배지용)
  Future<int> getPendingApplicationCount();
}

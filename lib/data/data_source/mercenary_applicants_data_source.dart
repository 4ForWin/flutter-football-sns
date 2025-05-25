import 'package:mercenaryhub/data/dto/mercenary_applicant_dto.dart';

abstract interface class MercenaryApplicantsDataSource {
  /// 특정 팀에 지원한 용병 목록 조회
  /// [teamUid] 사용자 ID
  Future<List<MercenaryApplicantDto>> fetchMercenaryApplicants(String teamUid);

  /// 용병 지원에 대한 응답 (수락/거절)
  /// [applicationId] 지원 ID
  /// [response] 'accepted' 또는 'rejected'
  Future<bool> respondToMercenaryApplication({
    required String applicationId,
    required String response,
  });

  /// 특정 지원 내역 상세 조회
  /// [applicationId] 지원 ID
  Future<MercenaryApplicantDto?> fetchMercenaryApplicantById(
      String applicationId);

  /// 지원 상태 업데이트
  /// [applicationId] 지원 ID
  /// [newStatus] 새로운 상태
  Future<bool> updateApplicationStatus({
    required String applicationId,
    required String newStatus,
  });

  /// 현재 사용자 등록한 팀 피드들의 ID 목록 조회
  /// 해당 팀 피드들에 지원한 용병들을 조회하기 위함
  Future<List<String>> fetchMyTeamFeedIds();

  /// 특정 팀 피드에 지원한 용병 수 조회
  /// [teamFeedId] 팀 피드 ID
  Future<int> getApplicantCount(String teamFeedId);

  /// 현재 사용자의 대기중인 지원 수 조회 (알림 배지용)
  Future<int> getPendingApplicationCount();

  /// 지원 내역 생성 (용병이 팀에 지원할 때 호출)
  /// [applicationData] 지원 정보
  Future<bool> createMercenaryApplication(Map<String, dynamic> applicationData);

  /// 지원 내역 삭제 (용병이 지원을 취소할 때 호출)
  /// [applicationId] 지원 ID
  Future<bool> deleteMercenaryApplication(String applicationId);

  /// 특정 용병의 특정 팀에 대한 지원 내역 조회
  /// [mercenaryUid] 용병 사용자 ID
  /// [teamFeedId] 팀 피드 ID
  Future<MercenaryApplicantDto?> fetchApplicationByMercenaryAndTeam({
    required String mercenaryUid,
    required String teamFeedId,
  });

  /// 모든 팀 피드에 대한 지원 통계 조회
  /// [teamUid]사용자 ID
  Future<Map<String, int>> getApplicationStatistics(String teamUid);
}

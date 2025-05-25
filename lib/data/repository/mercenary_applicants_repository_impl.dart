import 'package:mercenaryhub/data/data_source/mercenary_applicants_data_source.dart';
import 'package:mercenaryhub/domain/entity/mercenary_applicant.dart';
import 'package:mercenaryhub/domain/repository/mercenary_applicants_repository.dart';

class MercenaryApplicantsRepositoryImpl
    implements MercenaryApplicantsRepository {
  final MercenaryApplicantsDataSource _dataSource;

  MercenaryApplicantsRepositoryImpl(this._dataSource);

  @override
  Future<List<MercenaryApplicant>> fetchMercenaryApplicants(
      String teamUid) async {
    try {
      print('🚕 Repository: fetchMercenaryApplicants 호출 - teamUid: $teamUid');

      final dtoList = await _dataSource.fetchMercenaryApplicants(teamUid);

      print('🚕 Repository: ${dtoList.length}개의 지원자 DTO 조회');

      // DTO를 Entity로 변환
      return dtoList.map((dto) {
        return MercenaryApplicant(
          applicationId: dto.applicationId,
          mercenaryUid: dto.mercenaryUid,
          mercenaryName: dto.mercenaryName,
          profileImage: dto.profileImage,
          teamFeedId: dto.teamFeedId,
          teamName: dto.teamName,
          cost: dto.cost,
          level: dto.level,
          location: dto.location,
          gameDate: DateTime.parse(dto.gameDate),
          gameTime: dto.gameTime,
          appliedAt: DateTime.parse(dto.appliedAt),
          status: dto.status,
          content: dto.content,
        );
      }).toList();
    } catch (e) {
      print('❌ Repository fetchMercenaryApplicants error: $e');
      return [];
    }
  }

  @override
  Future<bool> respondToMercenaryApplication({
    required String applicationId,
    required String response,
  }) async {
    try {
      print('🚕 Repository: respondToMercenaryApplication 호출');
      print('   - applicationId: $applicationId');
      print('   - response: $response');

      final success = await _dataSource.respondToMercenaryApplication(
        applicationId: applicationId,
        response: response,
      );

      if (success) {
        print('🚕 Repository: 용병 지원 응답 완료');
      } else {
        print('❌ Repository: 용병 지원 응답 실패');
      }

      return success;
    } catch (e) {
      print('❌ Repository respondToMercenaryApplication error: $e');
      return false;
    }
  }

  @override
  Future<MercenaryApplicant?> fetchMercenaryApplicantById(
      String applicationId) async {
    try {
      print('🚕 Repository: fetchMercenaryApplicantById 호출 - $applicationId');

      final dto = await _dataSource.fetchMercenaryApplicantById(applicationId);

      if (dto == null) {
        print('⚠️ Repository: 지원 내역을 찾을 수 없음');
        return null;
      }

      print('🚕 Repository: 지원 내역 상세 조회 완료');

      // DTO를 Entity로 변환
      return MercenaryApplicant(
        applicationId: dto.applicationId,
        mercenaryUid: dto.mercenaryUid,
        mercenaryName: dto.mercenaryName,
        profileImage: dto.profileImage,
        teamFeedId: dto.teamFeedId,
        teamName: dto.teamName,
        cost: dto.cost,
        level: dto.level,
        location: dto.location,
        gameDate: DateTime.parse(dto.gameDate),
        gameTime: dto.gameTime,
        appliedAt: DateTime.parse(dto.appliedAt),
        status: dto.status,
        content: dto.content,
      );
    } catch (e) {
      print('❌ Repository fetchMercenaryApplicantById error: $e');
      return null;
    }
  }

  @override
  Future<bool> updateApplicationStatus({
    required String applicationId,
    required String newStatus,
  }) async {
    try {
      print('🚕 Repository: updateApplicationStatus 호출');
      print('   - applicationId: $applicationId');
      print('   - newStatus: $newStatus');

      final success = await _dataSource.updateApplicationStatus(
        applicationId: applicationId,
        newStatus: newStatus,
      );

      if (success) {
        print('🚕 Repository: 지원 상태 업데이트 완료');
      } else {
        print('❌ Repository: 지원 상태 업데이트 실패');
      }

      return success;
    } catch (e) {
      print('❌ Repository updateApplicationStatus error: $e');
      return false;
    }
  }

  @override
  Future<List<String>> fetchMyTeamFeedIds() async {
    try {
      print('🚕 Repository: fetchMyTeamFeedIds 호출');

      final feedIds = await _dataSource.fetchMyTeamFeedIds();

      print('🚕 Repository: ${feedIds.length}개의 팀 피드 ID 조회 완료');

      return feedIds;
    } catch (e) {
      print('❌ Repository fetchMyTeamFeedIds error: $e');
      return [];
    }
  }

  @override
  Future<int> getApplicantCount(String teamFeedId) async {
    try {
      print('🚕 Repository: getApplicantCount 호출 - $teamFeedId');

      final count = await _dataSource.getApplicantCount(teamFeedId);

      print('🚕 Repository: 지원자 수 조회 완료 - $count명');

      return count;
    } catch (e) {
      print('❌ Repository getApplicantCount error: $e');
      return 0;
    }
  }

  @override
  Future<int> getPendingApplicationCount() async {
    try {
      print('🚕 Repository: getPendingApplicationCount 호출');

      final count = await _dataSource.getPendingApplicationCount();

      print('🚕 Repository: 대기중인 지원 수 조회 완료 - $count개');

      return count;
    } catch (e) {
      print('❌ Repository getPendingApplicationCount error: $e');
      return 0;
    }
  }

  /// 추가 비즈니스 로직: 지원 가능 여부 확인
  Future<bool> canApplyToTeam({
    required String mercenaryUid,
    required String teamFeedId,
  }) async {
    try {
      print('🚕 Repository: canApplyToTeam 호출');
      print('   - mercenaryUid: $mercenaryUid');
      print('   - teamFeedId: $teamFeedId');

      // 이미 지원한 내역이 있는지 확인
      final existingApplication =
          await _dataSource.fetchApplicationByMercenaryAndTeam(
        mercenaryUid: mercenaryUid,
        teamFeedId: teamFeedId,
      );

      final canApply = existingApplication == null;
      print('🚕 Repository: 지원 가능 여부 - $canApply');

      return canApply;
    } catch (e) {
      print('❌ Repository canApplyToTeam error: $e');
      return false;
    }
  }

  /// 추가 비즈니스 로직: 지원 통계 조회
  Future<Map<String, int>> getTeamApplicationStatistics(String teamUid) async {
    try {
      print('🚕 Repository: getTeamApplicationStatistics 호출 - $teamUid');

      final statistics = await _dataSource.getApplicationStatistics(teamUid);

      print('🚕 Repository: 지원 통계 조회 완료');
      print('   - 전체: ${statistics['total']}건');
      print('   - 대기중: ${statistics['pending']}건');
      print('   - 수락: ${statistics['accepted']}건');
      print('   - 거절: ${statistics['rejected']}건');

      return statistics;
    } catch (e) {
      print('❌ Repository getTeamApplicationStatistics error: $e');
      return {
        'total': 0,
        'pending': 0,
        'accepted': 0,
        'rejected': 0,
        'cancelled': 0,
      };
    }
  }

  /// 추가 비즈니스 로직: 대량 상태 업데이트
  Future<bool> updateMultipleApplications({
    required List<String> applicationIds,
    required String newStatus,
  }) async {
    try {
      print('🚕 Repository: updateMultipleApplications 호출');
      print('   - ${applicationIds.length}개 지원 업데이트');
      print('   - newStatus: $newStatus');

      // 모든 업데이트가 성공해야 true 반환
      for (final applicationId in applicationIds) {
        final success = await _dataSource.updateApplicationStatus(
          applicationId: applicationId,
          newStatus: newStatus,
        );

        if (!success) {
          print('❌ Repository: 지원 $applicationId 업데이트 실패');
          return false;
        }
      }

      print('🚕 Repository: 대량 상태 업데이트 완료');
      return true;
    } catch (e) {
      print('❌ Repository updateMultipleApplications error: $e');
      return false;
    }
  }
}

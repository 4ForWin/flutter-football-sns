import 'package:mercenaryhub/domain/repository/mercenary_applicants_repository.dart';

class RespondToMercenaryApplicationUsecase {
  final MercenaryApplicantsRepository _repository;

  RespondToMercenaryApplicationUsecase(this._repository);

  /// 용병 지원에 대한 응답 (수락/거절)
  /// [applicationId] 지원 ID
  /// [response] 'accepted' 또는 'rejected'
  Future<bool> execute({
    required String applicationId,
    required String response,
  }) async {
    try {
      print('🚗 UseCase: respondToMercenaryApplication 실행');
      print('   - applicationId: $applicationId');
      print('   - response: $response');

      // 유효한 응답인지 확인
      if (!_isValidResponse(response)) {
        print('❌ UseCase: 잘못된 응답 타입 - $response');
        return false;
      }

      final success = await _repository.respondToMercenaryApplication(
        applicationId: applicationId,
        response: response,
      );

      if (success) {
        print('✅ UseCase: 용병 지원 응답 완료 - $response');
      } else {
        print('❌ UseCase: 용병 지원 응답 실패');
      }

      return success;
    } catch (e) {
      print('❌ RespondToMercenaryApplicationUsecase error: $e');
      return false;
    }
  }

  /// 지원 수락 (편의 메서드)
  /// [applicationId] 지원 ID
  Future<bool> acceptApplication(String applicationId) async {
    return await execute(
      applicationId: applicationId,
      response: 'accepted',
    );
  }

  /// 지원 거절 (편의 메서드)
  /// [applicationId] 지원 ID
  Future<bool> rejectApplication(String applicationId) async {
    return await execute(
      applicationId: applicationId,
      response: 'rejected',
    );
  }

  /// 지원 상태 업데이트 (일반적인 상태 변경용)
  /// [applicationId] 지원 ID
  /// [newStatus] 새로운 상태 ('pending', 'accepted', 'rejected', 'cancelled')
  Future<bool> updateStatus({
    required String applicationId,
    required String newStatus,
  }) async {
    try {
      print('🚗 UseCase: updateApplicationStatus 실행');
      print('   - applicationId: $applicationId');
      print('   - newStatus: $newStatus');

      // 유효한 상태인지 확인
      if (!_isValidStatus(newStatus)) {
        print('❌ UseCase: 잘못된 상태 - $newStatus');
        return false;
      }

      final success = await _repository.updateApplicationStatus(
        applicationId: applicationId,
        newStatus: newStatus,
      );

      if (success) {
        print('✅ UseCase: 지원 상태 업데이트 완료 - $newStatus');
      } else {
        print('❌ UseCase: 지원 상태 업데이트 실패');
      }

      return success;
    } catch (e) {
      print('❌ RespondToMercenaryApplicationUsecase updateStatus error: $e');
      return false;
    }
  }

  /// 유효한 응답 타입인지 확인
  bool _isValidResponse(String response) {
    return response == 'accepted' || response == 'rejected';
  }

  /// 유효한 상태인지 확인
  bool _isValidStatus(String status) {
    const validStatuses = ['pending', 'accepted', 'rejected', 'cancelled'];
    return validStatuses.contains(status);
  }
}

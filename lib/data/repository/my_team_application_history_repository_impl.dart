import 'package:mercenaryhub/data/data_source/my_team_application_history_data_source.dart';
import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';
import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';

class MyTeamApplicationHistoryRepositoryImpl
    implements MyTeamApplicationHistoryRepository {
  final MyTeamApplicationHistoryDataSource _dataSource;

  MyTeamApplicationHistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<MyTeamApplicationHistory>> fetchApplicationHistories() async {
    try {
      print('🚕 Repository: fetchApplicationHistories 호출');
      final dtoList = await _dataSource.fetchApplicationHistories();
      print('🚕 Repository: ${dtoList.length}개의 신청 내역 조회');

      return dtoList.map((dto) {
        return MyTeamApplicationHistory(
          teamName: dto.teamName,
          uid: dto.uid,
          feedId: dto.feedId,
          cost: dto.cost,
          level: dto.level,
          imageUrl: dto.imageUrl,
          location: dto.location,
          date: DateTime.parse(dto.date),
          time: dto.time,
          appliedAt: DateTime.parse(dto.appliedAt),
          status: dto.status,
        );
      }).toList();
    } catch (e) {
      print('❌ Repository fetchApplicationHistories error: $e');
      return [];
    }
  }

  @override
  Future<bool> applyToTeam(String feedId) async {
    try {
      print('🚕 Repository: applyToTeam 호출 - feedId: $feedId');
      await _dataSource.applyToTeam(feedId);
      print('🚕 Repository: 팀 신청 데이터 저장 완료');
      return true;
    } catch (e) {
      print('❌ Repository applyToTeam error: $e');
      return false;
    }
  }
}

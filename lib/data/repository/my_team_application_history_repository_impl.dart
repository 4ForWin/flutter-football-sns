import 'package:mercenaryhub/data/data_source/my_team_application_history_data_source.dart';
import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';
import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';

class MyTeamApplicationHistoryRepositoryImpl
    implements MyTeamApplicationHistoryRepository {
  final MyTeamApplicationHistoryDataSource _dataSource;

  MyTeamApplicationHistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<MyTeamApplicationHistory>> fetchApplicationHistories() async {
    print('🚕🚕🚕🚕');
    final dtoList = await _dataSource.fetchApplicationHistories();

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
          status: dto.status);
    }).toList();
  }

  // @override
  // Future<bool> cancelApply(String applyHistoryId) async {
  //   return await _dataSource.cancelApply(applyHistoryId);
  // }

  // @override
  // Future<MercenaryApplyHistory?> fetchMercenaryApplyHistoryById(
  //     String applyHistoryId) async {
  //   final dto =
  //       await _dataSource.fetchMercenaryApplyHistoryById(applyHistoryId);

  //   if (dto == null) return null;

  //   return MercenaryApplyHistory(
  //     id: dto.id,
  //     userId: dto.userId,
  //     teamId: dto.teamId,
  //     teamName: dto.teamName,
  //     teamProfileImage: dto.teamProfileImage,
  //     feedId: dto.feedId,
  //     appliedAt: DateTime.parse(dto.appliedAt),
  //     status: dto.status,
  //     location: dto.location,
  //     gameDate: DateTime.parse(dto.gameDate),
  //     gameTime: dto.gameTime,
  //     cost: dto.cost,
  //     level: dto.level,
  //   );
  // }

  @override
  void applyToTeam(String feedId) {
    _dataSource.applyToTeam(feedId);
  }
}

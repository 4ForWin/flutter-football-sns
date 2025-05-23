import 'package:mercenaryhub/data/data_source/team_apply_history_data_source.dart';
import 'package:mercenaryhub/domain/entity/team_apply_history.dart';
import 'package:mercenaryhub/domain/repository/team_apply_history_repository.dart';

class TeamApplyHistoryRepositoryImpl implements TeamApplyHistoryRepository {
  final TeamApplyHistoryDataSource _dataSource;

  TeamApplyHistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<TeamApplyHistory>> fetchTeamApplyHistories(String teamId) async {
    final dtoList = await _dataSource.fetchTeamApplyHistories(teamId);

    return dtoList.map((dto) {
      return TeamApplyHistory(
        id: dto.id,
        teamName: dto.teamName,
        mercenaryUserId: dto.mercenaryUserId,
        mercenaryName: dto.mercenaryName,
        mercenaryProfileImage: dto.mercenaryProfileImage,
        feedId: dto.feedId,
        appliedAt: DateTime.parse(dto.appliedAt),
        status: dto.status,
        location: dto.location,
        gameDate: DateTime.parse(dto.gameDate),
        gameTime: dto.gameTime,
        level: dto.level,
      );
    }).toList();
  }

  @override
  Future<bool> updateApplyStatus({
    required String applyHistoryId,
    required String status,
  }) async {
    return await _dataSource.updateApplyStatus(
      applyHistoryId: applyHistoryId,
      status: status,
    );
  }

  @override
  Future<TeamApplyHistory?> fetchTeamApplyHistoryById(
      String applyHistoryId) async {
    final dto = await _dataSource.fetchTeamApplyHistoryById(applyHistoryId);

    if (dto == null) return null;

    return TeamApplyHistory(
      id: dto.id,
      teamName: dto.teamName,
      mercenaryUserId: dto.mercenaryUserId,
      mercenaryName: dto.mercenaryName,
      mercenaryProfileImage: dto.mercenaryProfileImage,
      feedId: dto.feedId,
      appliedAt: DateTime.parse(dto.appliedAt),
      status: dto.status,
      location: dto.location,
      gameDate: DateTime.parse(dto.gameDate),
      gameTime: dto.gameTime,
      level: dto.level,
    );
  }
}

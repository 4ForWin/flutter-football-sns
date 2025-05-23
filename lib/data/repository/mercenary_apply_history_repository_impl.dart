import 'package:mercenaryhub/data/data_source/mercenary_apply_history_data_source.dart';
import 'package:mercenaryhub/domain/entity/mercenary_apply_history.dart';
import 'package:mercenaryhub/domain/repository/mercenary_apply_history_repository.dart';

class MercenaryApplyHistoryRepositoryImpl
    implements MercenaryApplyHistoryRepository {
  final MercenaryApplyHistoryDataSource _dataSource;

  MercenaryApplyHistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<MercenaryApplyHistory>> fetchMercenaryApplyHistories(
      String userId) async {
    final dtoList = await _dataSource.fetchMercenaryApplyHistories(userId);

    return dtoList.map((dto) {
      return MercenaryApplyHistory(
        id: dto.id,
        userId: dto.userId,
        teamId: dto.teamId,
        teamName: dto.teamName,
        teamProfileImage: dto.teamProfileImage,
        feedId: dto.feedId,
        appliedAt: DateTime.parse(dto.appliedAt),
        status: dto.status,
        location: dto.location,
        gameDate: DateTime.parse(dto.gameDate),
        gameTime: dto.gameTime,
        cost: dto.cost,
        level: dto.level,
      );
    }).toList();
  }

  @override
  Future<bool> cancelApply(String applyHistoryId) async {
    return await _dataSource.cancelApply(applyHistoryId);
  }

  @override
  Future<MercenaryApplyHistory?> fetchMercenaryApplyHistoryById(
      String applyHistoryId) async {
    final dto =
        await _dataSource.fetchMercenaryApplyHistoryById(applyHistoryId);

    if (dto == null) return null;

    return MercenaryApplyHistory(
      id: dto.id,
      userId: dto.userId,
      teamId: dto.teamId,
      teamName: dto.teamName,
      teamProfileImage: dto.teamProfileImage,
      feedId: dto.feedId,
      appliedAt: DateTime.parse(dto.appliedAt),
      status: dto.status,
      location: dto.location,
      gameDate: DateTime.parse(dto.gameDate),
      gameTime: dto.gameTime,
      cost: dto.cost,
      level: dto.level,
    );
  }
}

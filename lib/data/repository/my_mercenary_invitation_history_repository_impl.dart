import 'package:mercenaryhub/data/data_source/my_mercenary_invitation_history_data_source.dart';
import 'package:mercenaryhub/data/data_source/my_team_application_history_data_source.dart';
import 'package:mercenaryhub/domain/entity/my_mercenary_invitation_history.dart';
import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';
import 'package:mercenaryhub/domain/repository/my_mercenary_invitation_history_repository.dart';
import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';

class MyMercenaryInvitationHistoryRepositoryImpl
    implements MyMercenaryInvitationHistoryRepository {
  final MyMercenaryInvitationHistoryDataSource _dataSource;

  MyMercenaryInvitationHistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<MyMercenaryInvitationHistory>> fetchInvitationHistories() async {
    print('🚕🚕🚕🚕');
    final dtoList = await _dataSource.fetchInvitationHistories();

    return dtoList.map((dto) {
      return MyMercenaryInvitationHistory(
          name: dto.name,
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
  void inviteToMercenary(String feedId) {
    _dataSource.inviteToMercenary(feedId);
  }
}

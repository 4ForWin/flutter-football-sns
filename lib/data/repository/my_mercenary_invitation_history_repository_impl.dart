import 'package:mercenaryhub/data/data_source/my_mercenary_invitation_history_data_source.dart';
import 'package:mercenaryhub/domain/entity/my_mercenary_invitation_history.dart';
import 'package:mercenaryhub/domain/repository/my_mercenary_invitation_history_repository.dart';

class MyMercenaryInvitationHistoryRepositoryImpl
    implements MyMercenaryInvitationHistoryRepository {
  final MyMercenaryInvitationHistoryDataSource _dataSource;

  MyMercenaryInvitationHistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<MyMercenaryInvitationHistory>> fetchInvitationHistories() async {
    try {
      print('🚕 Repository: fetchInvitationHistories 호출');
      final dtoList = await _dataSource.fetchInvitationHistories();
      print('🚕 Repository: ${dtoList.length}개의 초대 내역 조회');

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
          status: dto.status,
        );
      }).toList();
    } catch (e) {
      print(' Repository fetchInvitationHistories error: $e');
      return [];
    }
  }

  @override
  Future<bool> inviteToMercenary(String feedId) async {
    try {
      print('🚕 Repository: inviteToMercenary 호출 - feedId: $feedId');
      await _dataSource.inviteToMercenary(feedId);
      print('🚕 Repository: 용병 초대 데이터 저장 완료');
      return true;
    } catch (e) {
      print(' Repository inviteToMercenary error: $e');
      return false;
    }
  }
}

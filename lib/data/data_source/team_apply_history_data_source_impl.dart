import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/data_source/team_apply_history_data_source.dart';
import 'package:mercenaryhub/data/dto/team_apply_history_dto.dart';

class TeamApplyHistoryDataSourceImpl implements TeamApplyHistoryDataSource {
  final FirebaseFirestore _firebaseFirestore;

  TeamApplyHistoryDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<TeamApplyHistoryDto>> fetchTeamApplyHistories(
      String teamId) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('teamApplyHistories')
          .where('teamId', isEqualTo: teamId)
          .orderBy('appliedAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return TeamApplyHistoryDto.fromJson({
          'id': doc.id,
          ...data,
        });
      }).toList();
    } catch (e) {
      print('fetchTeamApplyHistories error: $e');
      return [];
    }
  }

  @override
  Future<bool> updateApplyStatus({
    required String applyHistoryId,
    required String status,
  }) async {
    try {
      await _firebaseFirestore
          .collection('teamApplyHistories')
          .doc(applyHistoryId)
          .update({
        'status': status,
        'updatedAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print('updateApplyStatus error: $e');
      return false;
    }
  }

  @override
  Future<TeamApplyHistoryDto?> fetchTeamApplyHistoryById(
      String applyHistoryId) async {
    try {
      final doc = await _firebaseFirestore
          .collection('teamApplyHistories')
          .doc(applyHistoryId)
          .get();

      if (doc.exists) {
        return TeamApplyHistoryDto.fromJson({
          'id': doc.id,
          ...doc.data()!,
        });
      }
      return null;
    } catch (e) {
      print('fetchTeamApplyHistoryById error: $e');
      return null;
    }
  }
}

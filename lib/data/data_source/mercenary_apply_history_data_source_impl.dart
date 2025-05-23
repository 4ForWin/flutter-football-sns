import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/data_source/mercenary_apply_history_data_source.dart';
import 'package:mercenaryhub/data/dto/mercenary_apply_history_dto.dart';

class MercenaryApplyHistoryDataSourceImpl
    implements MercenaryApplyHistoryDataSource {
  final FirebaseFirestore _firebaseFirestore;

  MercenaryApplyHistoryDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<MercenaryApplyHistoryDto>> fetchMercenaryApplyHistories(
      String userId) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('mercenaryApplyHistories')
          .where('userId', isEqualTo: userId)
          .orderBy('appliedAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return MercenaryApplyHistoryDto.fromJson({
          'id': doc.id,
          ...data,
        });
      }).toList();
    } catch (e) {
      print('fetchMercenaryApplyHistories error: $e');
      return [];
    }
  }

  @override
  Future<bool> cancelApply(String applyHistoryId) async {
    try {
      await _firebaseFirestore
          .collection('mercenaryApplyHistories')
          .doc(applyHistoryId)
          .update({
        'status': 'cancelled',
        'cancelledAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print('cancelApply error: $e');
      return false;
    }
  }

  @override
  Future<MercenaryApplyHistoryDto?> fetchMercenaryApplyHistoryById(
      String applyHistoryId) async {
    try {
      final doc = await _firebaseFirestore
          .collection('mercenaryApplyHistories')
          .doc(applyHistoryId)
          .get();

      if (doc.exists) {
        return MercenaryApplyHistoryDto.fromJson({
          'id': doc.id,
          ...doc.data()!,
        });
      }
      return null;
    } catch (e) {
      print('fetchMercenaryApplyHistoryById error: $e');
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/data_source/mercenary_feed_log_data_source.dart';
import 'package:mercenaryhub/data/dto/mercenary_feed_log_dto.dart';

class MercenaryFeedLogDataSourceImpl implements MercenaryFeedLogDataSource {
  final FirebaseFirestore _firestoreInstance; // FirebaseFirestore.instance;

  MercenaryFeedLogDataSourceImpl(this._firestoreInstance);

  @override
  Future<List<MercenaryFeedLogDto>> fetchMercenaryFeedLogs(String uid) async {
    try {
      print('💻💻💻');
      print(uid);
      print('💻💻💻');
      var collectionQuery = await _firestoreInstance
          .collection('mercenaryFeedLogs')
          .where('uid', isEqualTo: uid)
          .get();

      final docs = collectionQuery.docs;
      print(docs.length);
      return docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return MercenaryFeedLogDto.fromJson(newMap);
      }).toList();
    } catch (e, s) {
      print('❌fetchMercenaryFeedLogs e: $e');
      print('❌fetchMercenaryFeedLogs s: $s');
      return [];
    }
  }

  @override
  Future<bool> insertMercenaryFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    try {
      final collectionRef = _firestoreInstance.collection('mercenaryFeedLogs');
      DocumentReference documentRef = collectionRef.doc();

      await documentRef.set({
        "uid": uid,
        "feedId": feedId,
        "isApplicant": isApplicant,
      });

      return true;
    } catch (e, s) {
      print('❌insertMercenaryFeedLog e: $e');
      print('❌insertMercenaryFeedLog s: $s');
      return false;
    }
  }
}

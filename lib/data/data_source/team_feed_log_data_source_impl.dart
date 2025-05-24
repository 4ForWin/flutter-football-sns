import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/data_source/team_feed_log_data_source.dart';
import 'package:mercenaryhub/data/dto/feed_log_dto.dart';

class TeamFeedLogDataSourceImpl implements TeamFeedLogDataSource {
  final FirebaseFirestore _firestoreInstance; // FirebaseFirestore.instance;

  TeamFeedLogDataSourceImpl(this._firestoreInstance);

  @override
  Future<List<FeedLogDto>> fetchTeamFeedLogs(String uid) async {
    try {
      print('💻💻💻');
      print(uid);
      print('💻💻💻');
      var collectionQuery = await _firestoreInstance
          .collection('feedLog')
          .where('uid', isEqualTo: uid)
          .get();

      final docs = collectionQuery.docs;
      print(docs.length);
      return docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return FeedLogDto.fromJson(newMap);
      }).toList();
    } catch (e, s) {
      print('❌fetchFeedLogs e: $e');
      print('❌fetchFeedLogs s: $s');
      return [];
    }
  }

  @override
  Future<bool> insertTeamFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    try {
      final collectionRef = _firestoreInstance.collection('feedLog');
      DocumentReference documentRef = collectionRef.doc();

      await documentRef.set({
        "uid": uid,
        "feedId": feedId,
        "isApplicant": isApplicant,
      });

      return true;
    } catch (e, s) {
      print('❌insertFeedLog e: $e');
      print('❌insertFeedLog s: $s');
      return false;
    }
  }
}

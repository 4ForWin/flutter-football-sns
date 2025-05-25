import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/data_source/team_feed_log_data_source.dart';
import 'package:mercenaryhub/data/dto/team_feed_log_dto.dart';

class TeamFeedLogDataSourceImpl implements TeamFeedLogDataSource {
  final FirebaseFirestore _firestoreInstance; // FirebaseFirestore.instance;

  TeamFeedLogDataSourceImpl(this._firestoreInstance);

  @override
  Future<List<TeamFeedLogDto>> fetchTeamFeedLogs(String uid) async {
    try {
      print('💻💻💻');
      print(uid);
      print('💻💻💻');
      var collectionQuery = await _firestoreInstance
          .collection('teamFeedLogs')
          .where('uid', isEqualTo: uid)
          .get();

      final docs = collectionQuery.docs;
      print(docs.length);
      return docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return TeamFeedLogDto.fromJson(newMap);
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
      final collectionRef = _firestoreInstance.collection('teamFeedLogs');
      DocumentReference documentRef = collectionRef.doc();

      await documentRef.set({
        "uid": uid,
        "feedId": feedId,
        "isApplicant": isApplicant,
      });

      return true;
    } catch (e, s) {
      print('❌insertTeamFeedLog e: $e');
      print('❌insertTeamFeedLog s: $s');
      return false;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/data_source/feed_log_data_source.dart';
import 'package:mercenaryhub/data/dto/feed_dto.dart';
import 'package:mercenaryhub/data/dto/feed_log_dto.dart';

class FeedLogDataSourceImpl implements FeedLogDataSource {
  final FirebaseFirestore _firestoreInstance; // FirebaseFirestore.instance;

  FeedLogDataSourceImpl(this._firestoreInstance);

  @override
  Future<List<FeedLogDto>> fetchFeedLogs(String uid) async {
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
  Future<bool> insertFeedLog({
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

  // @override
  // Future<void> addUserToList(Feed feed, SwipeDirection direction) async {
  //   final collectionRef = _firestoreInstance.collection('feeds');
  //   final documentRef = collectionRef.doc(feed.id);
  //   final doc = (await documentRef.get()).data();

  //   switch (direction) {
  //     case SwipeDirection.left:
  //       break;

  //     case SwipeDirection.right:
  //       print('오른쪽!!!👍');
  //       await documentRef.update({
  //         'applicant': [...feed.applicant, 'hj'],
  //       });

  //       break;

  //     default:
  //       break;
  //   }
  // }

  // @override
  // Future<void> addUserToList(Feed feed, SwipeDirection direction) async {
  //   return;
  //   final uid = 'hj'; // 🔁 실제로는 FirebaseAuth.instance.currentUser!.uid
  //   final docRef = _firestoreInstance.collection('feeds').doc(feed.id);

  //   switch (direction) {
  //     case SwipeDirection.left:
  //       // ❌ 거절한 사용자 리스트에 추가
  //       await docRef.update({
  //         'rejectedUsers': FieldValue.arrayUnion([uid]),
  //       });
  //       break;

  //     case SwipeDirection.right:
  //       // ✅ 수락한 사용자 리스트에 추가
  //       await docRef.update({
  //         'applicant': FieldValue.arrayUnion([uid]),
  //       });
  //       break;

  //     default:
  //       break;
  //   }
  // }
}

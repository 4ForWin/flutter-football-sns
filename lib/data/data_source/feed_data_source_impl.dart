import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/data_source/feed_data_source.dart';
import 'package:mercenaryhub/data/dto/feed_dto.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FeedDataSourceImpl implements FeedDataSource {
  final FirebaseFirestore _firestoreInstance; // FirebaseFirestore.instance;

  FeedDataSourceImpl(this._firestoreInstance);

  @override
  Future<List<FeedDto>> fetchFeeds(
    String? lastId,
    List<String> ignoreIds,
  ) async {
    try {
      var collectionQuery = _firestoreInstance
          .collection('feeds')
          .where(FieldPath.documentId, whereNotIn: ignoreIds)
          .orderBy('createAt', descending: true);

      if (lastId != null) {
        print('✅피드 데이터 소스 : $lastId');
        final lastDoc =
            await _firestoreInstance.collection('feeds').doc(lastId).get();
        collectionQuery = collectionQuery.startAfterDocument(lastDoc);
      }

      final docs = (await collectionQuery.limit(4).get()).docs;

      return docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return FeedDto.fromJson(newMap);
      }).toList();
    } catch (e, s) {
      print('❌fetchFeeds e: $e');
      print('❌fetchFeeds s: $s');
      return [];
    }
  }

  @override
  Future<bool> insertFeed({
    required String cost,
    required String person,
    required String imageUrl,
    required String teamName,
    required String location,
    required String level,
    required DateTime date,
    required TimeState time,
    required String content,
  }) async {
    try {
      final collectionRef = _firestoreInstance.collection('feeds');
      DocumentReference documentRef = collectionRef.doc();

      await documentRef.set({
        'cost': cost,
        'person': person,
        'imageUrl': imageUrl,
        'teamName': teamName,
        'location': location,
        'createAt': DateTime.now().toIso8601String(),
        'level': level,
        'date': date
            .toIso8601String(), // 파이어베이스에 추가할때는 타입이 DateTime -> String으로 변경해서 하기
        'time': time.toJson(), // toJson에서 자동으로 totoIso8601String()를 함
        'content': content,
        'reactions': [],
      });

      return true;
    } catch (e, s) {
      print('❌insertFeed e: $e');
      print('❌insertFeed s: $s');
      return false;
    }
  }

  @override
  Stream<List<FeedDto>> streamFetchFeeds() {
    // orderBy('createAt', descending: true); - createAt속성을 기준으로 정렬.
    // descending == true : 내림차순
    // descending == false : 오름차순
    final collectionRef = _firestoreInstance
        .collection('feeds')
        .orderBy('createAt', descending: true);
    final stream = collectionRef.snapshots();

    return stream.map((event) {
      print('✅event');
      print(event.docs[0].data());
      print(event.docs[1].data());
      print(event.docs[2].data());
      return event.docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return FeedDto.fromJson(newMap);
      }).toList();
    });
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

  @override
  Future<void> addUserToList(Feed feed, SwipeDirection direction) async {
    return;
    final uid = 'hj'; // 🔁 실제로는 FirebaseAuth.instance.currentUser!.uid
    final docRef = _firestoreInstance.collection('feeds').doc(feed.id);

    switch (direction) {
      case SwipeDirection.left:
        // ❌ 거절한 사용자 리스트에 추가
        await docRef.update({
          'rejectedUsers': FieldValue.arrayUnion([uid]),
        });
        break;

      case SwipeDirection.right:
        // ✅ 수락한 사용자 리스트에 추가
        await docRef.update({
          'applicant': FieldValue.arrayUnion([uid]),
        });
        break;

      default:
        break;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/data/data_source/team_feed_data_source.dart';
import 'package:mercenaryhub/data/dto/team_feed_dto.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';

class TeamFeedDataSourceImpl implements TeamFeedDataSource {
  final FirebaseFirestore _firestoreInstance; // FirebaseFirestore.instance;

  TeamFeedDataSourceImpl(this._firestoreInstance);

  @override
  Future<List<TeamFeedDto>> fetchTeamFeeds({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  }) async {
    try {
      var collectionQuery = _firestoreInstance
          .collection('teamFeeds')
          // TODO: 나중에 본인 uid 아닌 것들을 가져오기
          // .where('uid', whereNotIn: [uid])
          .where('location', isEqualTo: location)
          .orderBy('createAt', descending: true);

      if (ignoreIds.isNotEmpty) {
        collectionQuery =
            collectionQuery.where(FieldPath.documentId, whereNotIn: ignoreIds);
        print('💄💄');
        print(collectionQuery);
        print('💄💄');
      }

      if (lastId != null) {
        print('✅피드 데이터 소스 : $lastId');
        final lastDoc =
            await _firestoreInstance.collection('teamFeeds').doc(lastId).get();
        collectionQuery = collectionQuery.startAfterDocument(lastDoc);
      }

      final docs = (await collectionQuery.limit(4).get()).docs;

      return docs.map((doc) {
        print('💕💕💕💕💕');
        print(doc.data());
        print('💕💕💕💕💕');
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return TeamFeedDto.fromJson(newMap);
      }).toList();
    } catch (e, s) {
      print('❌fetchTeamFeeds e: $e');
      print('❌fetchTeamFeeds s: $s');
      return [];
    }
  }

  @override
  Future<bool> insertTeamFeed({
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
      final collectionRef = _firestoreInstance.collection('teamFeeds');
      DocumentReference documentRef = collectionRef.doc();

      await documentRef.set({
        'uid': FirebaseAuth.instance.currentUser?.uid,
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
      });

      return true;
    } catch (e, s) {
      print('❌insertTeamFeed e: $e');
      print('❌insertTeamFeed s: $s');
      return false;
    }
  }

  @override
  Stream<List<TeamFeedDto>> streamFetchTeamFeeds() {
    // orderBy('createAt', descending: true); - createAt속성을 기준으로 정렬.
    // descending == true : 내림차순
    // descending == false : 오름차순
    final collectionRef = _firestoreInstance
        .collection('teamFeeds')
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
        return TeamFeedDto.fromJson(newMap);
      }).toList();
    });
  }
}

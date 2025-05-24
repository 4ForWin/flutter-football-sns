import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/data/data_source/mercenary_feed_data_source.dart';
import 'package:mercenaryhub/data/dto/mercenary_feed_dto.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';

class MercenaryFeedDataSourceImpl implements MercenaryFeedDataSource {
  final FirebaseFirestore _firestoreInstance; // FirebaseFirestore.instance;

  MercenaryFeedDataSourceImpl(this._firestoreInstance);

  @override
  Future<List<MercenaryFeedDto>> fetchMercenaryFeeds({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  }) async {
    try {
      var collectionQuery = _firestoreInstance
          .collection('mercenaryFeeds')
          // TODO: 나중에 본인 uid 아닌 것들을 가져오기
          // .where('uid', whereNotIn: [uid])
          .where('location', isEqualTo: location)
          .orderBy('createAt', descending: true);

      if (ignoreIds.isNotEmpty) {
        collectionQuery =
            collectionQuery.where(FieldPath.documentId, whereNotIn: ignoreIds);
      }

      if (lastId != null) {
        print('✅피드 데이터 소스 : $lastId');
        final lastDoc = await _firestoreInstance
            .collection('mercenaryFeeds')
            .doc(lastId)
            .get();
        collectionQuery = collectionQuery.startAfterDocument(lastDoc);
      }

      final docs = (await collectionQuery.limit(4).get()).docs;

      return docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return MercenaryFeedDto.fromJson(newMap);
      }).toList();
    } catch (e, s) {
      print('❌fetchMercenaryFeeds e: $e');
      print('❌fetchMercenaryFeeds s: $s');
      return [];
    }
  }

  @override
  Future<bool> insertMercenaryFeed({
    required String cost,
    required String imageUrl,
    required String name,
    required String location,
    required String level,
    required DateTime date,
    required TimeState time,
    required String content,
  }) async {
    try {
      final collectionRef = _firestoreInstance.collection('mercenaryFeeds');
      DocumentReference documentRef = collectionRef.doc();

      await documentRef.set({
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'cost': cost,
        'imageUrl': imageUrl,
        'name': name,
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
      print('❌insertMercenaryFeed e: $e');
      print('❌insertMercenaryFeed s: $s');
      return false;
    }
  }

  @override
  Stream<List<MercenaryFeedDto>> streamFetchMercenaryFeeds() {
    // orderBy('createAt', descending: true); - createAt속성을 기준으로 정렬.
    // descending == true : 내림차순
    // descending == false : 오름차순
    final collectionRef = _firestoreInstance
        .collection('mercenaryFeeds')
        .orderBy('createAt', descending: true);
    final stream = collectionRef.snapshots();

    return stream.map((event) {
      return event.docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return MercenaryFeedDto.fromJson(newMap);
      }).toList();
    });
  }
}

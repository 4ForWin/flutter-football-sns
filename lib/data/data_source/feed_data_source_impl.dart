import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/data_source/feed_data_source.dart';
import 'package:mercenaryhub/data/dto/feed_dto.dart';

class FeedDataSourceImpl implements FeedDataSource {
  final FirebaseFirestore _firestoreInstance; // FirebaseFirestore.instance;

  FeedDataSourceImpl(this._firestoreInstance);
  @override
  Future<List<FeedDto>> fetchFeeds() async {
    try {
      final collectionRresult =
          await _firestoreInstance.collection('feeds').get();
      final docs = collectionRresult.docs;
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
    required String title,
    required String content,
    required String imageUrl,
    required String teamName,
    required String location,
  }) async {
    try {
      final collectionRef = _firestoreInstance.collection('feeds');
      DocumentReference documentRef = collectionRef.doc();

      await documentRef.set({
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
        'teamName': teamName,
        'location': location,
        'createAt': DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e, s) {
      print('❌insertFeed e: $e');
      print('❌insertFeed s: $s');
      return false;
    }
  }
}

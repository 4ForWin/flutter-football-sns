import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercenaryhub/data/dto/team_feed_dto.dart';

void main() {
  test('feed data source test', () async {
    final instance = FakeFirebaseFirestore();

    await instance.collection('feeds').add({
      'id': 'id',
      'title': 'title',
      'content': 'content',
      'imageUrl': 'imageUrl',
      'createAt': 'createAt'
    });
    final result = await instance.collection('feeds').get();

    final docs = result.docs;

    final feedDtoList = docs.map((doc) {
      final map = doc.data();
      final newMap = {'id': doc.id, ...map};
      return TeamFeedDto.fromJson(newMap);
    }).toList();

    expect(feedDtoList.first.id, 'id');
    expect(feedDtoList.first.title, 'title');
    expect(feedDtoList.first.content, 'content');
    expect(feedDtoList.first.imageUrl, 'imageUrl');
    expect(feedDtoList.first.createAt, 'createAt');
  });
}

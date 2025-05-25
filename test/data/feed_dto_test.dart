import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mercenaryhub/data/dto/team_feed_dto.dart';

void main() {
  test('feed dto test', () async {
// {
//   "id": "id",
//   "title": "title",
//   "content": "content",
//   "imageUrl": "imageUrl",
//   "createAt": "createAt"
// }

    final feedMap =
        jsonDecode(File('test/dummy/feed_dto.json').readAsStringSync());
    final feed = TeamFeedDto.fromJson(feedMap);

    expect(feed.id, 'id');
    expect(feed.title, 'title');
    expect(feed.content, 'content');
    expect(feed.imageUrl, 'imageUrl');
    expect(feed.createAt, 'createAt');
  });
}

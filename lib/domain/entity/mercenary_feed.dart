import 'package:mercenaryhub/domain/entity/time_state.dart';

class MercenaryFeed {
  String id;
  String cost;
  String imageUrl;
  String name;
  String location;
  String level;
  DateTime date;
  TimeState time;
  String content;

  MercenaryFeed({
    required this.id,
    required this.cost,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.level,
    required this.date,
    required this.time,
    required this.content,
  });
}

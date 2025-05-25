import 'package:mercenaryhub/domain/entity/time_state.dart';

class TeamFeed {
  String id;
  String cost;
  String person;
  String imageUrl;
  String teamName;
  String location;
  String level;
  DateTime date;
  TimeState time;
  String content;

  TeamFeed({
    required this.id,
    required this.cost,
    required this.person,
    required this.imageUrl,
    required this.teamName,
    required this.location,
    required this.level,
    required this.date,
    required this.time,
    required this.content,
  });
}

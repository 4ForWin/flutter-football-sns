import 'package:mercenaryhub/domain/entity/time_state.dart';

class Feed {
  String id;
  String cost;
  String person;
  String imageUrl;
  String teamName;
  String location;
  String level;
  DateTime date;
  TimeState time;

  Feed({
    required this.id,
    required this.cost,
    required this.person,
    required this.imageUrl,
    required this.teamName,
    required this.location,
    required this.level,
    required this.date,
    required this.time,
  });
}

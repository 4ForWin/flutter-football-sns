class TeamApplyHistory {
  final String id;
  final String teamName;
  final String mercenaryUserId;
  final String mercenaryName;
  final String mercenaryProfileImage;
  final String feedId;
  final DateTime appliedAt;
  final String status; // pending, accepted, rejected
  final String location;
  final DateTime gameDate;
  final String gameTime;
  final String level;

  TeamApplyHistory({
    required this.id,
    required this.teamName,
    required this.mercenaryUserId,
    required this.mercenaryName,
    required this.mercenaryProfileImage,
    required this.feedId,
    required this.appliedAt,
    required this.status,
    required this.location,
    required this.gameDate,
    required this.gameTime,
    required this.level,
  });
}

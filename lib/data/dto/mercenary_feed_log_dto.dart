class MercenaryFeedLogDto {
  final String feedId;
  final bool isApplicant;
  final String uid;

  MercenaryFeedLogDto({
    required this.feedId,
    required this.isApplicant,
    required this.uid,
  });

  factory MercenaryFeedLogDto.fromJson(Map<String, dynamic> json) =>
      MercenaryFeedLogDto(
        feedId: json["feedId"],
        isApplicant: json["isApplicant"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "feedId": feedId,
        "isApplicant": isApplicant,
        "uid": uid,
      };
}

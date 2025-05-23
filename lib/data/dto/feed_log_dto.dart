class FeedLogDto {
  final String feedId;
  final bool isApplicant;
  final String uid;

  FeedLogDto({
    required this.feedId,
    required this.isApplicant,
    required this.uid,
  });

  factory FeedLogDto.fromJson(Map<String, dynamic> json) => FeedLogDto(
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

class AdWatchDto {
  final bool adWatched;

  AdWatchDto({
    required this.adWatched,
  });

  factory AdWatchDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return AdWatchDto(
      adWatched: json['ad_watched'] as bool,
    );
  }
}
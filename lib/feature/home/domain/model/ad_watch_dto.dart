class AdWatchDto {
  final bool watched;

  AdWatchDto({
    required this.watched,
  });

  factory AdWatchDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return AdWatchDto(
      watched: json['watched'] as bool,
    );
  }
}
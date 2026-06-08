class VersionDto {
  final String minVersion;
  final String latestVersion;

  VersionDto({
    required this.minVersion,
    required this.latestVersion
  });

  factory VersionDto.fromJson(Map<String, dynamic> json) {
    return VersionDto(
      minVersion: json['minimum_version'],
      latestVersion: json['latest_version']
    );
  }
}
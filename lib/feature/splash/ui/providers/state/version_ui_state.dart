import '../../../domain/model/version_dto.dart';

class VersionUiState {
  final VersionDto? version;

  const VersionUiState({
    this.version,
  });

  VersionDto get displayVersion {
    return version ??
        VersionDto(
          minVersion: '',
          latestVersion: '',
        );
  }

  VersionUiState copyWith({
    VersionDto? version,
  }) {
    return VersionUiState(
      version: version ?? this.version,
    );
  }
}
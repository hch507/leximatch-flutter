import '../../../domain/model/version_dto.dart';

class SplashUiState {
  final VersionDto? version;

  const SplashUiState({
    this.version,
  });

  VersionDto get displayVersion {
    return version ??
        VersionDto(
          minVersion: '',
          latestVersion: '',
        );
  }

  SplashUiState copyWith({
    VersionDto? version,
  }) {
    return SplashUiState(
      version: version ?? this.version,
    );
  }
}
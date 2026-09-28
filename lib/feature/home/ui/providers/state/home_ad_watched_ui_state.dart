import '../../../domain/model/ad_watch_dto.dart';

class HomeAdWatchedUiState {
  final AdWatchDto? adWatch;

  const HomeAdWatchedUiState({
    this.adWatch,
  });

  AdWatchDto get displayAdWatch {
    return adWatch ??
        AdWatchDto(
          watched: false,
        );
  }

  HomeAdWatchedUiState copyWith({
    AdWatchDto? adWatch,
  }) {
    return HomeAdWatchedUiState(
      adWatch: adWatch ?? this.adWatch,
    );
  }
}
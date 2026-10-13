import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/ad_watch_dto.dart';
import '../../../domain/providers/ad_repository_provider.dart';
import '../../../domain/repository/ad_repository.dart';
import 'home_ad_watched_ui_state.dart';

class HomeAdWatchedNotifier
    extends AutoDisposeAsyncNotifier<HomeAdWatchedUiState> {

  late final AdRepository _adRepository =
  ref.read(adRepositoryProvider);
  bool _isFetching = false;
  @override
  FutureOr<HomeAdWatchedUiState> build() {
    return const HomeAdWatchedUiState();
  }

  Future<AdWatchDto?> fetchAdWatch() async {
    if (_isFetching) return null;

    _isFetching = true;

    try {
      final adWatch = await _adRepository.fetchAdWatch();

      state = AsyncData(
        HomeAdWatchedUiState(
          adWatch: adWatch,
        ),
      );

      return adWatch;

      return adWatch;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    } finally {
      _isFetching = false;
    }
  }

  Future<void> saveAdWatch() async {
    state = const AsyncLoading();

    try {
      await _adRepository.saveAdWatch();

      state = AsyncData(
        HomeAdWatchedUiState(
          adWatch: AdWatchDto(
            adWatched: true,
          ),
        ),
      );
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      rethrow;
    }
  }
}
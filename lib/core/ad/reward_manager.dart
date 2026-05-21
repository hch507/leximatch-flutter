import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum RewardAdState {
  idle,
  loading,
  loaded,
  failed,
  showing,
}

class RewardAdManager {
  RewardedAd? _rewardedAd;

  RewardAdState _state = RewardAdState.idle;
  LoadAdError? _lastLoadError;

  bool _disposed = false;

  bool get isReady => _rewardedAd != null;
  bool get isLoading => _state == RewardAdState.loading;
  bool get isShowing => _state == RewardAdState.showing;
  bool get isFailed => _state == RewardAdState.failed;

  RewardAdState get state => _state;
  LoadAdError? get lastLoadError => _lastLoadError;

  String get _adUnitId {
    if (Platform.isIOS) {
      // TEST
      // return 'ca-app-pub-3940256099942544/1712485313';

      // RELEASE
      return 'ca-app-pub-4893971090777365/9414099397';
    }

    if (Platform.isAndroid) {
      // TEST
      // return 'ca-app-pub-3940256099942544/5224354917';

      // RELEASE
      return 'ca-app-pub-4893971090777365/2054484126';
    }

    throw UnsupportedError('Unsupported platform');
  }

  void load() {
    if (_disposed) return;
    if (_state == RewardAdState.loading) return;
    if (_rewardedAd != null) return;

    _state = RewardAdState.loading;
    _lastLoadError = null;

    RewardedAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          if (_disposed) {
            ad.dispose();
            return;
          }

          _rewardedAd = ad;
          _state = RewardAdState.loaded;
          _lastLoadError = null;

          debugPrint('RewardedAd loaded');
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          _state = RewardAdState.failed;
          _lastLoadError = error;

          debugPrint(
            'RewardedAd load failed: '
                'code=${error.code}, '
                'message=${error.message}',
          );
        },
      ),
    );
  }

  void show({
    required VoidCallback onRewarded,
    VoidCallback? onLoading,
    VoidCallback? onLoadFailed,
    VoidCallback? onNotReady,
    VoidCallback? onFailedToShow,
    VoidCallback? onDismissed,
  }) {
    if (_disposed) return;
    if (_state == RewardAdState.showing) return;

    final ad = _rewardedAd;

    if (ad == null) {
      if (_state == RewardAdState.loading) {
        onLoading?.call();
        return;
      }

      if (_state == RewardAdState.failed) {
        onLoadFailed?.call();
        load();
        return;
      }

      onNotReady?.call();
      load();
      return;
    }

    _rewardedAd = null;
    _state = RewardAdState.showing;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();

        _state = RewardAdState.idle;

        onDismissed?.call();
        load();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();

        _state = RewardAdState.failed;

        debugPrint(
          'RewardedAd show failed: '
              'code=${error.code}, '
              'message=${error.message}',
        );

        onFailedToShow?.call();
        load();
      },
    );

    ad.show(
      onUserEarnedReward: (ad, reward) {
        onRewarded();
      },
    );
  }

  void dispose() {
    _disposed = true;

    _rewardedAd?.dispose();
    _rewardedAd = null;

    _state = RewardAdState.idle;
    _lastLoadError = null;
  }
}
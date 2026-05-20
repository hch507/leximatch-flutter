import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardAdManager {
  RewardedAd? _rewardedAd;

  bool _isLoading = false;
  bool _isShowing = false;
  bool _disposed = false;

  bool get isReady => _rewardedAd != null;
  bool get isLoading => _isLoading;
  bool get isShowing => _isShowing;

  String get _adUnitId {
    if (Platform.isIOS) {
      // iOS Rewarded Test ID
      //TEST
      // return 'ca-app-pub-3940256099942544/1712485313';
      //Release
      return 'ca-app-pub-4893971090777365/9414099397';
    }

    if (Platform.isAndroid) {
      // Android Rewarded Test ID
      //TEST
      // return 'ca-app-pub-3940256099942544/5224354917';
      //Release
      return 'ca-app-pub-4893971090777365/2054484126';
    }

    throw UnsupportedError('Unsupported platform');
  }

  void load() {
    if (_disposed) return;
    if (_isLoading || _rewardedAd != null) return;

    _isLoading = true;

    RewardedAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          if (_disposed) {
            ad.dispose();
            return;
          }

          _isLoading = false;
          _rewardedAd = ad;
          debugPrint('RewardedAd loaded');
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          debugPrint('RewardedAd load failed: $error');
        },
      ),
    );
  }

  void show({
    required VoidCallback onRewarded,
    VoidCallback? onNotReady,
    VoidCallback? onFailedToShow,
    VoidCallback? onDismissed,
  }) {
    if (_disposed) return;
    if (_isShowing) return;

    final ad = _rewardedAd;

    if (ad == null) {
      onNotReady?.call();
      load();
      return;
    }

    _rewardedAd = null;
    _isShowing = true;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        _isShowing = false;
        ad.dispose();

        onDismissed?.call();
        load();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowing = false;
        ad.dispose();

        debugPrint('RewardedAd show failed: $error');

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
  }
}
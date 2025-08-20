import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/9214589741';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get InterstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  InterstitialAd? interstitialAd;
  int num_of_attempt_load = 0;

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            num_of_attempt_load = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            num_of_attempt_load++;
            interstitialAd = null;
            if (num_of_attempt_load <= 2) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
  }

  RewardedAd? _rewardedAd;

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      rewardedAdLoadCallback:
          RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
        _rewardedAd = ad;
      }, onAdFailedToLoad: (LoadAdError error) {
        loadRewardedAd();
      }),
      request: AdRequest(),
    );
  }

  void showRewardedAd() {
    _rewardedAd?.show(onUserEarnedReward: (ad, reward) {
      print('reward Earned');
    });
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadRewardedAd();
      },
      onAdImpression: (ad) {
        print('ad impression occured');
      },
    );
  }
}

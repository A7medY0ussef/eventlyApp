import 'package:evently/core/utils/app_assets.dart';

class OnboardingModel {
  final String lightImage;
  final String darkImage;
  final String titleKey;
  final String subTitleKey;
  final String? buttonTitleKey;

  OnboardingModel({
    required this.titleKey,
    required this.subTitleKey,
    required this.lightImage,
    required this.darkImage,
    this.buttonTitleKey = 'onboarding_next',
  });
}

final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    titleKey: 'onboarding_findEvents_title',
    subTitleKey: 'onboarding_findEvents_subtitle',
    lightImage: AppAssets.hotTrendingLightImage,
    darkImage: AppAssets.hotTrendingDarkImage,
  ),

  OnboardingModel(
    titleKey: 'onboarding_eventPlanning_title',
    subTitleKey: 'onboarding_eventPlanning_subtitle',
    lightImage: AppAssets.managerDeskLightImage,
    darkImage: AppAssets.managerDeskDarkImage,
  ),

  OnboardingModel(
    titleKey: 'onboarding_connectFriends_title',
    subTitleKey: 'onboarding_connectFriends_subtitle',
    lightImage: AppAssets.socialMediaLightImage,
    darkImage: AppAssets.socialMediaDarkImage,
    buttonTitleKey: 'onboarding_getStarted',
  ),
];
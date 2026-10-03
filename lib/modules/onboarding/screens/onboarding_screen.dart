import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/onboarding_item_widget.dart';
import '../widgets/personalization_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageViewController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void next() {
    _pageViewController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void back() {
    _pageViewController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void goToLogIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  String title(AppLocalizations l10n, int i) {
    switch (i) {
      case 0:
        return l10n.onboarding_findEvents_title;
      case 1:
        return l10n.onboarding_eventPlanning_title;
      default:
        return l10n.onboarding_connectFriends_title;
    }
  }

  String subTitle(AppLocalizations l10n, int i) {
    switch (i) {
      case 0:
        return l10n.onboarding_findEvents_subtitle;
      case 1:
        return l10n.onboarding_eventPlanning_subtitle;
      default:
        return l10n.onboarding_connectFriends_subtitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (currentIndex > 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: AppbarWidget(
                  showBack: currentIndex > 1,
                  tapBack: back,
                  tapSkip: goToLogIn,
                ),
              )
            else
              const SizedBox(height: 24),

            Expanded(
              child: PageView.builder(
                controller: _pageViewController,
                onPageChanged: (i) => setState(() => currentIndex = i),
                itemCount: onboardingData.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return PersonalizationWidget(onStart: next);
                  }

                  final pageIndex = index - 1;
                  final isLast = index == onboardingData.length;

                  return OnboardingItemWidget(
                    item: onboardingData[pageIndex],
                    title: title(AppLocalizations.of(context)!, pageIndex),
                    subTitle: subTitle(
                      AppLocalizations.of(context)!,
                      pageIndex,
                    ),
                    buttonTitle: isLast
                        ? AppLocalizations.of(context)!.onboarding_getStarted
                        : AppLocalizations.of(context)!.onboarding_next,
                    onTap: isLast ? goToLogIn : next,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

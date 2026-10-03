import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @onboarding_title.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get onboarding_title;

  /// No description provided for @onboarding_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get onboarding_subtitle;

  /// No description provided for @onboarding_labelLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get onboarding_labelLanguage;

  /// No description provided for @onboarding_langEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get onboarding_langEnglish;

  /// No description provided for @onboarding_langArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get onboarding_langArabic;

  /// No description provided for @onboarding_labelTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get onboarding_labelTheme;

  /// No description provided for @onboarding_btnStart.
  ///
  /// In en, this message translates to:
  /// **'Let’s start'**
  String get onboarding_btnStart;

  /// No description provided for @onboarding_findEvents_title.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get onboarding_findEvents_title;

  /// No description provided for @onboarding_findEvents_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get onboarding_findEvents_subtitle;

  /// No description provided for @onboarding_eventPlanning_title.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get onboarding_eventPlanning_title;

  /// No description provided for @onboarding_eventPlanning_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get onboarding_eventPlanning_subtitle;

  /// No description provided for @onboarding_connectFriends_title.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get onboarding_connectFriends_title;

  /// No description provided for @onboarding_connectFriends_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get onboarding_connectFriends_subtitle;

  /// No description provided for @onboarding_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next;

  /// No description provided for @onboarding_getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboarding_getStarted;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get login_title;

  /// No description provided for @login_forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get login_forgetPassword;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_button;

  /// No description provided for @login_noAccountText.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account ? '**
  String get login_noAccountText;

  /// No description provided for @login_signupLink.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get login_signupLink;

  /// No description provided for @login_googleButton.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_googleButton;

  /// No description provided for @signup_title.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get signup_title;

  /// No description provided for @signup_nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get signup_nameHint;

  /// No description provided for @signup_confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get signup_confirmPasswordHint;

  /// No description provided for @signup_button.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup_button;

  /// No description provided for @signup_haveAccountText.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get signup_haveAccountText;

  /// No description provided for @signup_loginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get signup_loginLink;

  /// No description provided for @signup_googleButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signup_googleButton;

  /// No description provided for @auth_welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get auth_welcomeMessage;

  /// No description provided for @auth_welcomeBackMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back '**
  String get auth_welcomeBackMessage;

  /// No description provided for @auth_emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get auth_emailHint;

  /// No description provided for @auth_passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get auth_passwordHint;

  /// No description provided for @auth_or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get auth_or;

  /// No description provided for @validation_emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validation_emailRequired;

  /// No description provided for @validation_emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validation_emailInvalid;

  /// No description provided for @validation_passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validation_passwordRequired;

  /// No description provided for @validation_passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get validation_passwordTooShort;

  /// No description provided for @validation_nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get validation_nameRequired;

  /// No description provided for @validation_nameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters'**
  String get validation_nameTooShort;

  /// No description provided for @validation_confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validation_confirmPasswordRequired;

  /// No description provided for @validation_passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validation_passwordsDoNotMatch;

  /// No description provided for @auth_errorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak.'**
  String get auth_errorWeakPassword;

  /// No description provided for @auth_errorEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'The account already exists for that email.'**
  String get auth_errorEmailAlreadyInUse;

  /// No description provided for @auth_errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email.'**
  String get auth_errorUserNotFound;

  /// No description provided for @auth_errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password or email.'**
  String get auth_errorWrongPassword;

  /// No description provided for @auth_resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get auth_resetPassword;

  /// No description provided for @auth_showYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get auth_showYourEmail;

  /// No description provided for @auth_invalidMail.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get auth_invalidMail;

  /// No description provided for @profile_darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get profile_darkMode;

  /// No description provided for @profile_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profile_language;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_logout;

  /// No description provided for @profile_galleryProfile.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get profile_galleryProfile;

  /// No description provided for @profile_galleryCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get profile_galleryCamera;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get nav_favorite;

  /// No description provided for @nav_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get nav_profile;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

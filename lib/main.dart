import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/auth/screens/login_screen.dart';
import 'package:evently/modules/auth/screens/register_screen.dart';
import 'package:evently/modules/auth/screens/reset_password_screen.dart';
import 'package:evently/modules/layout/screens/layout_screen.dart';
import 'package:evently/modules/splash/screens/splash_screen.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'modules/auth/manager/auth_provider.dart';
import 'modules/layout/screens/home_screen.dart';
import 'modules/onboarding/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const EventlyApp(),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.splashScreen,
      routes: {
        AppRoutes.homeScreen: (context) => HomeScreen(),
        AppRoutes.onboardingScreen: (context) => const OnboardingScreen(),
        AppRoutes.loginScreen: (context) => const LoginScreen(),
        AppRoutes.registerScreen: (context) => const RegisterScreen(),
        AppRoutes.resetPasswordScreen: (context) => const ResetPasswordScreen(),
        AppRoutes.layoutScreen: (context) => const LayoutScreen(),
      },

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentTheme,
      home: SplashScreen(),
    );
  }
}

import 'package:evently/core/toast_service/toast.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  late User? user;

  Future<void> createAccount({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final l10n = AppLocalizations.of(context)!;
      final authService = AuthService();
      user = await authService.createAccount(
        email: email,
        password: password,
        name: name,
        l10n: AppLocalizations.of(context)!,
      );
      if (!context.mounted) return;
      Toast.show(title: '${l10n.auth_welcomeMessage} $name', context: context);
    } catch (e) {
      if (!context.mounted) return;
      Toast.show(title: e.toString(), context: context, type: ToastType.error);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final l10n = AppLocalizations.of(context)!;
      final authService = AuthService();
      user = await authService.logIn(
        email: email,
        password: password,
        l10n: AppLocalizations.of(context)!,
      );
      if (!context.mounted) return;
      Toast.show(
        title: '${l10n.auth_welcomeBackMessage} ${user?.displayName ?? ''}',
        context: context,
      );
    } catch (e) {
      if (!context.mounted) return;
      Toast.show(title: e.toString(), context: context, type: ToastType.error);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final l10n = AppLocalizations.of(context)!;
      final authService = AuthService();
      await authService.resetPassword(
        email: email,
        l10n: AppLocalizations.of(context)!,
      );
      if (!context.mounted) return;
      Toast.show(title: l10n.auth_showYourEmail, context: context);
    } catch (e) {
      if (!context.mounted) return;
      Toast.show(title: e.toString(), context: context, type: ToastType.error);
    }
    isLoading = false;
    notifyListeners();
  }
}

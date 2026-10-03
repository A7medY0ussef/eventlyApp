import 'package:evently/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<User?> createAccount({
    required String email,
    required String password,
    required String name,
    required AppLocalizations l10n,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateProfile(displayName: name);
      await credential.user?.updateDisplayName(name);
      await credential.user?.sendEmailVerification();
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw l10n.auth_errorWeakPassword;
      } else if (e.code == 'email-already-in-use') {
        throw l10n.auth_errorEmailAlreadyInUse;
      } else {
        throw e.message ?? "";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> logIn({
    required String email,
    required String password,
    required AppLocalizations l10n,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw l10n.auth_errorUserNotFound;
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw l10n.auth_errorWrongPassword;
      } else {
        throw e.message ?? "";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String email,
    required AppLocalizations l10n,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      throw l10n.auth_invalidMail;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }
}

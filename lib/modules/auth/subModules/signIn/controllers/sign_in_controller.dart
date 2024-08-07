import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/shared/controllers/session_controller.dart';
import 'package:my_coffee/core/shared/utils/loading.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage_keys.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs_keys.dart';
import 'package:my_coffee/core/shared/utils/snackbar.dart';
import 'package:my_coffee/core/shared/utils/tools.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';

part 'sign_in_controller.g.dart';

class SignInController = SignInControllerBase with _$SignInController;

abstract class SignInControllerBase with Store {
  final _sharedPrefs = Modular.get<SharedPrefs>();
  final _secureStorage = Modular.get<SecureStorage>();
  final _firebaseAuth = Modular.get<FirebaseAuth>();
  final _sessionController = Modular.get<SessionController>();
  final auth = LocalAuthentication();
  var validators = Validators();
  List<String>? emailsRegistered = [];

  Future<bool> isSuported() async => await auth.isDeviceSupported();

  @observable
  bool emailValid = false;

  @observable
  bool validFilds = false;

  @observable
  bool passwordVisible = true;

  @action
  void showBiometric({
    required String emailAddress,
    required BuildContext context,
  }) {
    var emailAddressValid = validators.emailValidator(emailAddress, context);

    if (emailAddressValid?.isEmpty ?? true && emailAddress.isNotEmpty) {
      emailValid = true;
    } else {
      emailValid = false;
    }
  }

  @action
  void validateAllFilds({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) {
    var emailAddressValid = validators.emailValidator(emailAddress, context);

    if (emailAddress.isNotEmpty && password.isNotEmpty && emailAddressValid == null) {
      validFilds = true;
    } else {
      validFilds = false;
    }
  }

  @action
  Future<void> login(
    String email,
    String password,
    BuildContext context, [
    bool withError = false,
  ]) async {
    try {
      await loading(context);
      if (withError) throw Exception();
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      _sessionController.saveUserSession(userCredential);
      await _secureStorage.save(email, password);
      await _secureStorage.save(
        email + SecureStorageKeys.token,
        DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
      );

      if (!context.mounted) return;
      removeLoading(context);
      showMessage(snackBarLoginSuccess(context), context);

      Modular.to.pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
    } on FirebaseAuthException catch (e) {
      removeLoading(context);
      switch (e.code) {
        case "invalid-credential":
          showMessage(snackBarPasswordOrEmailIncorrect(context), context);
          break;
        case "user-not-found":
          showMessage(snackBarUserNotFound(context), context);
          break;

        default:
          showMessage(snackBarFailure(context), context);
      }
    } catch (e) {
      if (!context.mounted) return;
      removeLoading(context);
      showMessage(snackBarFailure(context), context);
    }
  }

  Future<void> setEmail(TextEditingController emailEC, BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      List<String>? arguments = Modular.args.data ?? <String>[];
      if (arguments != null && arguments.isNotEmpty) {
        emailsRegistered = arguments;
        emailEC.text = emailsRegistered!.last;
        saveLastSelectedEmail(emailEC.text);
      } else {
        emailEC.text = await _sharedPrefs.load<String?>(SharedPrefsKeys.lastSelectedEmail) ?? "";
      }

      emailsRegistered = await _sharedPrefs.load<List<String>?>(SharedPrefsKeys.emailsRegistered) ?? [];

      if (!context.mounted) return;
      showBiometric(emailAddress: emailEC.text, context: context);
    } catch (e) {
      logger(e);
    }
  }

  Future<void> saveLastSelectedEmail(String lastSelectedEmail) async {
    try {
      await _sharedPrefs.save(SharedPrefsKeys.lastSelectedEmail, lastSelectedEmail);
    } catch (e) {
      logger(e);
    }
  }

  Future<void> removeRegisteredAccount(String email, TextEditingController emailEC) async {
    try {
      emailsRegistered = await _sharedPrefs.load<List<String>?>(SharedPrefsKeys.emailsRegistered) ?? [];
      emailsRegistered?.removeAt(emailsRegistered!.indexOf(email));
      var lastEmail = await _sharedPrefs.load<String?>(SharedPrefsKeys.lastSelectedEmail) ?? "";
      if (lastEmail == email) {
        emailEC.text = "";
        await _sharedPrefs.delete(SharedPrefsKeys.lastSelectedEmail);
      }
      await _sharedPrefs.save(SharedPrefsKeys.emailsRegistered, emailsRegistered);
    } catch (e) {
      logger(e);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      _sessionController.saveUserSession(userCredential);

      if (!context.mounted) return;
      showMessage(snackBarLoginSuccess(context), context);
      Modular.to.pushNamed(AppRoutes.home);
    } catch (e) {
      logger(e);
      if (!context.mounted) return;
      showMessage(snackBarFailure(context), context);
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.tokenString ?? "");
      var userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      _sessionController.saveUserSession(userCredential);

      if (!context.mounted) return;
      showMessage(snackBarLoginSuccess(context), context);
      Modular.to.pushNamed(AppRoutes.home);
    } catch (e) {
      if (!context.mounted) return;
      showMessage(snackBarFailure(context), context);
    }
  }

  Future<void> signInWithBiometric(String email, BuildContext context) async {
    try {
      final token = await _secureStorage.load<String>(email + SecureStorageKeys.token) ?? "";

      if (token.isEmpty) {
        if (!context.mounted) return;
        return showMessage(snackBarLoginEnableBiometric(context), context);
      }

      if (DateTime.parse(token).isAfter(DateTime.now())) {
        final password = await _secureStorage.load<String>(email) ?? "";

        final authenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint (or face or whatever) to authenticate',
          options: const AuthenticationOptions(stickyAuth: true),
        );

        if (authenticated) {
          if (!context.mounted) return;
          await login(email, password, context);
        } else {
          if (!context.mounted) return;
          return showMessage(snackBarFailure(context), context);
        }
      } else {
        if (!context.mounted) return;
        return showMessage(snackBarLoginExpiredBiometric(context), context);
      }
    } catch (e) {
      if (!context.mounted) return;
      showMessage(snackBarFailure(context), context);
    }
  }
}

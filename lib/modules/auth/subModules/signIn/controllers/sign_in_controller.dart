import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/shared/utils/loading.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs_keys.dart';
import 'package:my_coffee/core/shared/utils/snackbar.dart';
import 'package:my_coffee/core/shared/utils/tools.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/models/register_account_model.dart';

part 'sign_in_controller.g.dart';

class SignInController = SignInControllerBase with _$SignInController;

abstract class SignInControllerBase with Store {
  final _sharedPrefs = Modular.get<SharedPrefs>();
  final _firebaseAuth = Modular.get<FirebaseAuth>();
  List<String>? emailsRegistered = [];

  @observable
  bool validFilds = false;

  @observable
  bool passwordVisible = true;

  @action
  void validateAllFilds({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) {
    var validators = Validators();
    if (emailAddress.isNotEmpty && password.isNotEmpty) {
      var emailAddressValid = validators.emailValidator(emailAddress, context);

      if (emailAddressValid == null) {
        validFilds = true;
      } else {
        validFilds = false;
      }
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
      if (!context.mounted) return;
      removeLoading(context);
      showMessage(snackBarLoginSuccess(context), context);
      Modular.to.pushNamedAndRemoveUntil(
        AppRoutes.home,
        (_) => false,
        arguments: RegisterAccountModel(
          fullName: userCredential.user?.displayName ?? "",
          emailAddress: userCredential.user?.email ?? "",
          photoURL: userCredential.user?.photoURL,
        ),
      );
    } on FirebaseAuthException catch (e) {
      removeLoading(context);
      switch (e.code) {
        case "email-already-in-use":
          showMessage(snackBarEmailAlreadyRegistered(context), context);
          break;
        case "invalid-email":
          showMessage(snackBarEmailInvalid(context), context);
          break;
        case "wrong-password":
          showMessage(snackBarEmailWrongPassword(context), context);
          break;
        case "invalid-password":
          showMessage(snackBarEmailInvalidPassword(context), context);
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

  Future<void> setEmail(TextEditingController emailEC) async {
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

      var registerAccountModel = RegisterAccountModel(
        fullName: userCredential.user?.displayName ?? "",
        emailAddress: userCredential.user?.email ?? "",
        photoURL: userCredential.user?.photoURL,
      );

      if (!context.mounted) return;
      showMessage(snackBarLoginSuccess(context), context);
      Modular.to.pushNamed(AppRoutes.home, arguments: registerAccountModel);
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
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? "");
      var userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      var registerAccountModel = RegisterAccountModel(
        fullName: userCredential.user?.displayName ?? "",
        emailAddress: userCredential.user?.email ?? "",
        photoURL: userCredential.user?.photoURL,
      );

      if (!context.mounted) return;
      showMessage(snackBarLoginSuccess(context), context);
      Modular.to.pushNamed(AppRoutes.home, arguments: registerAccountModel);
    } catch (e) {
      if (!context.mounted) return;
      showMessage(snackBarFailure(context), context);
    }
  }
}

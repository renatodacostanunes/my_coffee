import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/shared/utils/loading.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage_keys.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs_keys.dart';
import 'package:my_coffee/core/shared/utils/snackbar.dart';
import 'package:my_coffee/core/shared/utils/tools.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/models/register_account_model.dart';

part 'sign_in_controller.g.dart';

class SignInController = SignInControllerBase with _$SignInController;

abstract class SignInControllerBase with Store {
  final _secureStorage = Modular.get<SecureStorage>();
  final _sharedPrefs = Modular.get<SharedPrefs>();
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
      var emailValid = await _secureStorage.contains(email);
      String? data = await _secureStorage.load(email);
      var registerAccountModel = RegisterAccountModel.fromJson(data ?? "");
      if (emailValid && registerAccountModel.password.isNotEmpty && password == registerAccountModel.password) {
        if (!context.mounted) return;
        removeLoading(context);
        showMessage(snackBarLoginSuccess(context), context);
        Modular.to.pushNamed(AppRoutes.home, arguments: registerAccountModel);
      } else {
        if (!context.mounted) return;
        removeLoading(context);
        showMessage(snackBarLoginPasswordIncorrect(context), context);
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
      List<String>? arguments = Modular.args.data;

      if (arguments != null && arguments.isNotEmpty) {
        emailsRegistered = arguments;
        emailEC.text = emailsRegistered!.last;
        saveLastSelectedEmail(emailEC.text);
      } else {
        emailEC.text = await _sharedPrefs.load<String?>(SharedPrefsKeys.lastSelectedEmail) ?? "";
      }

      emailsRegistered = await _sharedPrefs.load<List<String>?>(SecurageStorageKeys.emailsRegistered) ?? [];
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
      emailsRegistered = await _sharedPrefs.load<List<String>?>(SecurageStorageKeys.emailsRegistered) ?? [];
      emailsRegistered?.removeAt(emailsRegistered!.indexOf(email));
      var lastEmail = await _sharedPrefs.load<String?>(SharedPrefsKeys.lastSelectedEmail) ?? "";
      if (lastEmail == email) {
        emailEC.text = "";
        await _sharedPrefs.delete(SharedPrefsKeys.lastSelectedEmail);
      }
      await _secureStorage.delete(email);
      await _sharedPrefs.save(SecurageStorageKeys.emailsRegistered, emailsRegistered);
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
        password: "",
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
}

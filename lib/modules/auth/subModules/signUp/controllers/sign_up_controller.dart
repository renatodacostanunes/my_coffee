import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/shared/utils/loading.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs_keys.dart';
import 'package:my_coffee/core/shared/utils/snackbar.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';

part 'sign_up_controller.g.dart';

class SignUpController = SignUpControllerBase with _$SignUpController;

abstract class SignUpControllerBase with Store {
  final _sharedPrefs = Modular.get<SharedPrefs>();
  final _firebaseAuth = Modular.get<FirebaseAuth>();

  @observable
  bool validFilds = false;

  @observable
  bool passwordVisible = true;

  @observable
  bool confirmPasswordVisible = true;

  Future<void> registerAccount(
    String email,
    String password,
    String displayName,
    BuildContext context, [
    bool withError = false,
  ]) async {
    try {
      await loading(context);
      if (withError) throw Exception();

      await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (userCredential) => userCredential.user?.updateDisplayName(displayName),
          );

      List<String>? emailsRecovered;
      List<String> emailsRegistered = [];

      emailsRecovered = await _sharedPrefs.load(SharedPrefsKeys.emailsRegistered);
      if (emailsRecovered != null && emailsRecovered.isNotEmpty) {
        emailsRegistered = emailsRecovered..add(email);
      } else {
        emailsRegistered.add(email);
      }
      await _sharedPrefs.save(SharedPrefsKeys.emailsRegistered, emailsRegistered);

      if (!context.mounted) return;
      removeLoading(context);
      showMessage(snackBarRegisteredWithSuccess(context), context);
      Modular.to.pushNamed(
        AppRoutes.auth + AppRoutes.signIn,
        arguments: emailsRegistered,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        if (!context.mounted) return;
        removeLoading(context);
        showMessage(snackBarEmailAlreadyRegistered(context), context);
        return;
      }
    } catch (e) {
      if (!context.mounted) return;
      removeLoading(context);
      showMessage(snackBarFailure(context), context);
      return;
    }
  }

  @action
  void validateAllFilds({
    required String fullName,
    required String emailAddress,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) {
    var validators = Validators();
    if (fullName.isNotEmpty && emailAddress.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      var fullNameValid = validators.fullNameValidator(fullName, context);
      var emailAddressValid = validators.emailValidator(emailAddress, context);
      var passwordValid = validators.passwordValidator(password, context);
      var confirmPasswordValid = validators.confirmPasswordValidator(
        password: password,
        confirmPassword: confirmPassword,
        context: context,
      );
      if (fullNameValid == null && emailAddressValid == null && passwordValid == null && confirmPasswordValid == null) {
        validFilds = true;
      } else {
        validFilds = false;
      }
    } else {
      validFilds = false;
    }
  }
}

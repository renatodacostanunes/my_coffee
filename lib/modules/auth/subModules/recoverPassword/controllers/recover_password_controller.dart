import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/core/shared/utils/snackbar.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';

part 'recover_password_controller.g.dart';

class RecoverPasswordController = RecoverPasswordControllerBase with _$RecoverPasswordController;

abstract class RecoverPasswordControllerBase with Store {
  final _firebaseAuth = Modular.get<FirebaseAuth>();

  @observable
  bool emailValid = false;

  @action
  void validateEmail(String email, BuildContext context) {
    var valid = Validators().emailValidator(email, context);
    if (valid == null) {
      emailValid = true;
    } else {
      emailValid = false;
    }
  }

  @action
  Future<void> recoverPassword(String email, BuildContext context) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      if (!context.mounted) return;
      showMessage(snackBarRecordPassword(context), context);
      Modular.to.pop();
    } catch (e) {
      showMessage(snackBarFailure(context), context);
    }
  }
}

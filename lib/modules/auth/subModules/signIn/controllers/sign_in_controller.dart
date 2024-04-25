import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/core/shared/utils/loading.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage.dart';
import 'package:my_coffee/core/shared/utils/snackbar.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/models/register_account_model.dart';

part 'sign_in_controller.g.dart';

class SignInController = SignInControllerBase with _$SignInController;

abstract class SignInControllerBase with Store {
  final _secureStorage = Modular.get<SecureStorage>();

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
        showMessage(snackBarLoginSuccess, context);
      } else {
        if (!context.mounted) return;
        removeLoading(context);
        showMessage(snackBarLoginPasswordIncorrect, context);
      }
    } catch (e) {
      if (!context.mounted) return;
      removeLoading(context);
      showMessage(snackBarFailure, context);
    }
  }
}

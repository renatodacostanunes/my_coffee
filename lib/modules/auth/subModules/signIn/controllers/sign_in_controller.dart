import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/core/shared/utils/loading.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage_keys.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs_keys.dart';
import 'package:my_coffee/core/shared/utils/snackbar.dart';
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

  @action
  void validateAllFilds({
    required String emailAddress,
    required String password,
  }) {
    var validators = Validators();
    if (emailAddress.isNotEmpty && password.isNotEmpty) {
      var emailAddressValid = validators.emailValidator(emailAddress);

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

  Future<void> setEmail(TextEditingController emailEC) async {
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
  }

  Future<void> saveLastSelectedEmail(String lastSelectedEmail) async {
    await _sharedPrefs.save(SharedPrefsKeys.lastSelectedEmail, lastSelectedEmail);
  }
}

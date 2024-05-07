import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/shared/utils/loading.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage.dart';
import 'package:my_coffee/core/shared/utils/secure_storage/secure_storage_keys.dart';
import 'package:my_coffee/core/shared/utils/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/core/shared/utils/snackbar.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/models/register_account_model.dart';

part 'sign_up_controller.g.dart';

class SignUpController = SignUpControllerBase with _$SignUpController;

abstract class SignUpControllerBase with Store {
  final _secureStorage = Modular.get<SecureStorage>();
  final _sharedPrefs = SharedPrefs();

  @observable
  bool validFilds = false;

  @observable
  bool passwordVisible = false;

  @observable
  bool confirmPasswordVisible = false;

  Future<void> registerAccount(
    RegisterAccountModel registerAccountModel,
    BuildContext context, [
    bool withError = false,
  ]) async {
    try {
      await loading(context);
      if (withError) throw Exception();
      var emailExists = await _secureStorage.contains(registerAccountModel.emailAddress);
      if (emailExists) {
        if (!context.mounted) return;
        removeLoading(context);
        showMessage(snackBarEmailAlreadyRegistered, context);
        return;
      }
      await _secureStorage.save(
        registerAccountModel.emailAddress,
        RegisterAccountModel.fromMap(
          <String, dynamic>{
            "fullName": registerAccountModel.fullName,
            "emailAddress": registerAccountModel.emailAddress,
            "password": registerAccountModel.password,
          },
        ).toJson(),
      );

      List<String>? listEnconded;
      List<String> emailsRegistered = [];

      listEnconded = await _sharedPrefs.load(SecurageStorageKeys.emailsRegistered);
      if (listEnconded != null && listEnconded.isNotEmpty) {
        emailsRegistered = listEnconded..add(registerAccountModel.emailAddress);
      } else {
        emailsRegistered.add(registerAccountModel.emailAddress);
      }
      await _sharedPrefs.save(SecurageStorageKeys.emailsRegistered, emailsRegistered);

      final data = await _secureStorage.load<String>(registerAccountModel.emailAddress);
      if (data != null && data.isNotEmpty) {
        if (!context.mounted) return;
        removeLoading(context);
        showMessage(snackBarRegisteredWithSuccess, context);
        Modular.to.pushNamed(
          AppRoutes.auth + AppRoutes.signIn,
          arguments: emailsRegistered,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      removeLoading(context);
      showMessage(snackBarFailure, context);
    }
  }

  @action
  void validateAllFilds({
    required String fullName,
    required String emailAddress,
    required String password,
    required String confirmPassword,
  }) {
    var validators = Validators();
    if (fullName.isNotEmpty && emailAddress.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      var fullNameValid = validators.fullNameValidator(fullName);
      var emailAddressValid = validators.emailValidator(emailAddress);
      var passwordValid = validators.passwordValidator(password);
      var confirmPasswordValid = validators.confirmPasswordValidator(
        password: password,
        confirmPassword: confirmPassword,
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

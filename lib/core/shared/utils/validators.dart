import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_coffee/core/shared/utils/regex.dart';
import 'package:my_coffee/locale/language.dart';

class Validators {
  String? emailValidator(String? email, BuildContext context) {
    if ((email?.isNotEmpty ?? false) && !emailPattern.hasMatch(email!.trim())) {
      return Language().translation(context).invalidEmail;
    }
    return null;
  }

  String? fullNameValidator(String? name, BuildContext context) {
    var nameSplited = name?.trim().split(" ") ?? [];
    if ((name?.isEmpty ?? false) ||
        (nameSplited.length > 1 && nameSplited[0].length > 1 && nameSplited[1].length > 1) &&
            (namePattern.hasMatch(name?.trim() ?? ""))) {
      return null;
    }

    return Language().translation(context).invalidName;
  }

  String? passwordValidator(String? password, BuildContext context) {
    if (password == null || password.isEmpty || passwordPattern.hasMatch(password.trim())) return null;
    return "${Language().translation(context).passwordMustContain}\n${Language().translation(context).specialCharacter}\n${Language().translation(context).capitalLetter}\n${Language().translation(context).charactersMinimum}";
  }

  String? confirmPasswordValidator({
    required String? password,
    required String? confirmPassword,
    required BuildContext context,
  }) {
    if ((password?.isNotEmpty ?? false) && (confirmPassword?.isNotEmpty ?? false) && password == confirmPassword) {
      return null;
    }
    return Language().translation(context).passwordSame;
  }
}

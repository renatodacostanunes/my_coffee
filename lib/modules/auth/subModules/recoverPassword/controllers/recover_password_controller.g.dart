// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recover_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecoverPasswordController on RecoverPasswordControllerBase, Store {
  late final _$emailValidAtom =
      Atom(name: 'RecoverPasswordControllerBase.emailValid', context: context);

  @override
  bool get emailValid {
    _$emailValidAtom.reportRead();
    return super.emailValid;
  }

  @override
  set emailValid(bool value) {
    _$emailValidAtom.reportWrite(value, super.emailValid, () {
      super.emailValid = value;
    });
  }

  late final _$recoverPasswordAsyncAction = AsyncAction(
      'RecoverPasswordControllerBase.recoverPassword',
      context: context);

  @override
  Future<void> recoverPassword(String email, BuildContext context) {
    return _$recoverPasswordAsyncAction
        .run(() => super.recoverPassword(email, context));
  }

  late final _$RecoverPasswordControllerBaseActionController =
      ActionController(name: 'RecoverPasswordControllerBase', context: context);

  @override
  void validateEmail(String email, BuildContext context) {
    final _$actionInfo = _$RecoverPasswordControllerBaseActionController
        .startAction(name: 'RecoverPasswordControllerBase.validateEmail');
    try {
      return super.validateEmail(email, context);
    } finally {
      _$RecoverPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emailValid: ${emailValid}
    ''';
  }
}

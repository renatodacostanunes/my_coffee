// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInController on SignInControllerBase, Store {
  late final _$validFildsAtom =
      Atom(name: 'SignInControllerBase.validFilds', context: context);

  @override
  bool get validFilds {
    _$validFildsAtom.reportRead();
    return super.validFilds;
  }

  @override
  set validFilds(bool value) {
    _$validFildsAtom.reportWrite(value, super.validFilds, () {
      super.validFilds = value;
    });
  }

  late final _$passwordVisibleAtom =
      Atom(name: 'SignInControllerBase.passwordVisible', context: context);

  @override
  bool get passwordVisible {
    _$passwordVisibleAtom.reportRead();
    return super.passwordVisible;
  }

  @override
  set passwordVisible(bool value) {
    _$passwordVisibleAtom.reportWrite(value, super.passwordVisible, () {
      super.passwordVisible = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('SignInControllerBase.login', context: context);

  @override
  Future<void> login(String email, String password, BuildContext context,
      [bool withError = false]) {
    return _$loginAsyncAction
        .run(() => super.login(email, password, context, withError));
  }

  late final _$SignInControllerBaseActionController =
      ActionController(name: 'SignInControllerBase', context: context);

  @override
  void validateAllFilds(
      {required String emailAddress,
      required String password,
      required BuildContext context}) {
    final _$actionInfo = _$SignInControllerBaseActionController.startAction(
        name: 'SignInControllerBase.validateAllFilds');
    try {
      return super.validateAllFilds(
          emailAddress: emailAddress, password: password, context: context);
    } finally {
      _$SignInControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
validFilds: ${validFilds},
passwordVisible: ${passwordVisible}
    ''';
  }
}

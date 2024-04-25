// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpController on SignUpControllerBase, Store {
  late final _$validFildsAtom =
      Atom(name: 'SignUpControllerBase.validFilds', context: context);

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

  late final _$SignUpControllerBaseActionController =
      ActionController(name: 'SignUpControllerBase', context: context);

  @override
  void validateAllFilds(
      {required String fullName,
      required String emailAddress,
      required String password,
      required String confirmPassword}) {
    final _$actionInfo = _$SignUpControllerBaseActionController.startAction(
        name: 'SignUpControllerBase.validateAllFilds');
    try {
      return super.validateAllFilds(
          fullName: fullName,
          emailAddress: emailAddress,
          password: password,
          confirmPassword: confirmPassword);
    } finally {
      _$SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
validFilds: ${validFilds}
    ''';
  }
}

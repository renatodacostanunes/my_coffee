// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInController on SignInControllerBase, Store {
  late final _$loginAsyncAction =
      AsyncAction('SignInControllerBase.login', context: context);

  @override
  Future<void> login(String email, String password, BuildContext context,
      [bool withError = false]) {
    return _$loginAsyncAction
        .run(() => super.login(email, password, context, withError));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
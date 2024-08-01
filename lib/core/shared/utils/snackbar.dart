import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:my_coffee/locale/language.dart';

void showMessage(SnackBar snackBar, BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

SnackBar snackBarEmailAlreadyRegistered(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).warning,
        message: Language().translation(context).emailAlreadyRegistered,
        contentType: ContentType.warning,
      ),
    );

SnackBar snackBarRecordPassword(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).success,
        message: Language().translation(context).passwordRecoverySuccessfully,
        contentType: ContentType.success,
      ),
    );

SnackBar snackBarEmailInvalid(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).warning,
        message: Language().translation(context).invalidEmail,
        contentType: ContentType.warning,
      ),
    );

SnackBar snackBarEmailWrongPassword(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).warning,
        message: Language().translation(context).incorrectPassword,
        contentType: ContentType.warning,
      ),
    );

SnackBar snackBarEmailInvalidPassword(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).warning,
        message: Language().translation(context).invalidPassword,
        contentType: ContentType.warning,
      ),
    );

SnackBar snackBarRegisteredWithSuccess(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).success,
        message: Language().translation(context).userRegisteredSuccessfully,
        contentType: ContentType.success,
      ),
    );

SnackBar snackBarLoginSuccess(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).success,
        message: Language().translation(context).sessionExpires,
        contentType: ContentType.success,
      ),
    );

SnackBar snackBarLoginPasswordIncorrect(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).ops,
        message: Language().translation(context).incorrectPassword,
        contentType: ContentType.warning,
      ),
    );

SnackBar snackBarLoginEnableBiometric(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).ops,
        message: Language().translation(context).loginEnableBiometric,
        contentType: ContentType.warning,
      ),
    );

SnackBar snackBarLoginExpiredBiometric(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).ops,
        message: Language().translation(context).loginExpiredBiometric,
        contentType: ContentType.warning,
      ),
    );

SnackBar snackBarFailure(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).error,
        message: Language().translation(context).somethingWrong,
        contentType: ContentType.failure,
      ),
    );

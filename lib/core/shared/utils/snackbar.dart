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

SnackBar snackBarPasswordOrEmailIncorrect(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).error,
        message: Language().translation(context).emailOrPasswordInvalid,
        contentType: ContentType.failure,
      ),
    );

SnackBar snackBarUserNotFound(BuildContext context) => SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: Language().translation(context).error,
        message: Language().translation(context).userNotFound,
        contentType: ContentType.failure,
      ),
    );

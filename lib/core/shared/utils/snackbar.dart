import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showMessage(SnackBar snackBar, BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

final snackBarEmailAlreadyRegistered = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Warning',
    message: 'This email is already registered',
    contentType: ContentType.warning,
  ),
);

final snackBarRegisteredWithSuccess = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Success',
    message: 'User registered successfully',
    contentType: ContentType.success,
  ),
);

final snackBarLoginSuccess = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Success',
    message: 'Your session expires in 7 days',
    contentType: ContentType.help,
  ),
);

final snackBarLoginPasswordIncorrect = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Ops',
    message: 'Incorrect password',
    contentType: ContentType.warning,
  ),
);

final snackBarFailure = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Error',
    message: 'Something went wrong, try again later',
    contentType: ContentType.failure,
  ),
);

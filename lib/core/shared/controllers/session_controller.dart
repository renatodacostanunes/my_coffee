import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:my_coffee/locale/language.dart';

part 'session_controller.g.dart';

class SessionController = SessionControllerBase with _$SessionController;

abstract class SessionControllerBase with Store {
  String fullName = "";
  String emailAddress = "";
  String photoUrl = "";
  DateTime dateLogged = DateTime.now();

  void saveUserSession(UserCredential userCredential) {
    fullName = userCredential.user?.displayName ?? "";
    emailAddress = userCredential.user?.email ?? "";
    photoUrl = userCredential.user?.photoURL ?? "";
    dateLogged = DateTime.now();
  }

  DateTime sessionExpires() => dateLogged.add(const Duration(hours: 1));

  String getWelcomeMessage(BuildContext context) {
    int hour = DateTime.now().hour;
    var lang = Language().translation(context);
    if (hour <= 12) {
      return lang.goodMorning;
    } else if (hour >= 18) {
      return lang.goodNight;
    } else {
      return lang.goodAfternoon;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

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
}

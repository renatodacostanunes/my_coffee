import 'package:my_coffee/core/shared/utils/regex.dart';

class Validators {
  String? emailValidator(String? email) {
    if ((email?.isNotEmpty ?? false) && !emailPattern.hasMatch(email!.trim())) return "E-mail inválido";
    return null;
  }

  String? fullNameValidator(String? name) {
    var nameSplited = name?.trim().split(" ") ?? [];
    if ((name?.isEmpty ?? false) ||
        (nameSplited.length > 1 && nameSplited[0].length > 1 && nameSplited[1].length > 1)) {
      return null;
    }
    return "Nome inválido";
  }

  String? passwordValidator(String? password) {
    // Todo: Melhorar para mostrar quais etapas da senha estão corretas.
    if (password == null || password.isEmpty || passwordPattern.hasMatch(password.trim())) return null;
    return "A senha precisa conter pelo menos:\n1 Caracter especial\n1 Letra maíuscula\n6 Caracteres no mínimo";
  }

  String? confirmPasswordValidator({
    required String? password,
    required String? confirmPassword,
  }) {
    if ((password?.isNotEmpty ?? false) && (confirmPassword?.isNotEmpty ?? false) && password == confirmPassword) {
      return null;
    }
    return "As senhas devem ser iguais";
  }
}

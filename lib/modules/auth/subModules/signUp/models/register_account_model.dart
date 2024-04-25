import 'dart:convert';

class RegisterAccountModel {
  final String fullName;
  final String emailAddress;
  final String password;

  RegisterAccountModel({
    required this.fullName,
    required this.emailAddress,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'emailAddress': emailAddress,
      'password': password,
    };
  }

  factory RegisterAccountModel.fromMap(Map<String, dynamic> map) {
    return RegisterAccountModel(
      fullName: map['fullName'] as String,
      emailAddress: map['emailAddress'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterAccountModel.fromJson(String source) =>
      RegisterAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class RegisterAccountModel {
  final String fullName;
  final String emailAddress;
  final String password;
  final String? photoURL;

  RegisterAccountModel({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    this.photoURL,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'emailAddress': emailAddress,
      'password': password,
      'photoURL': photoURL,
    };
  }

  factory RegisterAccountModel.fromMap(Map<String, dynamic> map) {
    return RegisterAccountModel(
      fullName: map['fullName'] as String,
      emailAddress: map['emailAddress'] as String,
      password: map['password'] as String,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterAccountModel.fromJson(String source) =>
      RegisterAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

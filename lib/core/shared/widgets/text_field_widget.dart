import 'package:flutter/material.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/styles/colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
    this.autofocus = false,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: AppColors.greyLight),
    );
    final textStyle = TextStyle(color: AppColors.greyLight, fontSize: width * .035);
    return TextFormField(
      autofocus: autofocus,
      onChanged: onChanged,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      cursorColor: AppColors.primary,
      obscureText: obscureText,
      style: textStyle,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: double.maxFinite,
          maxWidth: double.maxFinite,
        ),
        filled: true,
        fillColor: AppColors.greyDark,
        border: borderStyle,
        enabledBorder: borderStyle,
        disabledBorder: borderStyle,
        focusedBorder: borderStyle,
        hintStyle: textStyle,
        hintText: hintText,
        errorStyle: TextStyle(fontSize: width * .035),
        contentPadding: const EdgeInsets.only(bottom: 0.0),
        prefix: Padding(padding: EdgeInsets.only(left: width * 0.05)),
      ),
    );
  }
}

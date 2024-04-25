import 'package:flutter/material.dart';
import 'package:my_coffee/core/styles/colors.dart';

Future<dynamic> loading(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    ),
  );
  await Future.delayed(const Duration(seconds: 1));
}

removeLoading(BuildContext context) => Navigator.of(context).pop();

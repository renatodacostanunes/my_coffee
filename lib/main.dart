import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/app_module.dart';
import 'package:my_coffee/app_widget.dart';

void main() async => runApp(ModularApp(module: AppModule(), child: const AppWidget()));

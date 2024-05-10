import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/utils/tools.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/models/register_account_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final args = Modular.args.data as RegisterAccountModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(args.fullName),
            Text(args.emailAddress),
            args.photoURL != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(width * 0.15),
                    child: Image.network(
                      args.photoURL!,
                      height: width * 0.15,
                      width: width * 0.15,
                    ),
                  )
                : Container(
                    height: width * 0.15,
                    width: width * 0.15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      shape: BoxShape.circle,
                    ),
                    child: Text(getNameInitials(args.fullName)),
                  ),
          ],
        ),
      ),
    );
  }
}

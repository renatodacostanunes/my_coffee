import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/controllers/session_controller.dart';
import 'package:my_coffee/core/shared/utils/tools.dart';
import 'package:my_coffee/core/styles/colors.dart';

class UserPerfilWidget extends StatelessWidget {
  UserPerfilWidget({super.key});
  final _sessionController = Modular.get<SessionController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: width * 0.14,
          height: width * 0.14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.14),
            color: _sessionController.photoUrl.isNotEmpty ? null : AppColors.primary,
          ),
          child: _sessionController.photoUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(width * 0.14),
                  child: Image.network(
                    _sessionController.photoUrl,
                    height: width * 0.14,
                    width: width * 0.14,
                  ),
                )
              : Text(
                  getNameInitials(_sessionController.fullName),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * .05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
        SizedBox(width: width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _sessionController.fullName,
              style: TextStyle(
                fontSize: width * 0.05,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.003),
            Text(
              _sessionController.getWelcomeMessage(context),
              style: TextStyle(
                fontSize: width * 0.035,
                color: AppColors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Container(
              height: width * .06,
              width: width * .06,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/search.png"),
                ),
              ),
            ),
            SizedBox(width: width * .04),
            Container(
              height: width * .06,
              width: width * .06,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/notification.png"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';
import 'package:my_coffee/core/shared/widgets/button_widget.dart';
import 'package:my_coffee/core/shared/widgets/text_field_widget.dart';
import 'package:my_coffee/core/styles/colors.dart';
import 'package:my_coffee/locale/language.dart';
import 'package:my_coffee/modules/auth/subModules/recoverPassword/controllers/recover_password_controller.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key, required this.controller});

  final RecoverPasswordController controller;
  @override
  RecoverPasswordPageState createState() => RecoverPasswordPageState();
}

class RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _validators = Validators();
  final _emailEC = TextEditingController();

  @override
  void initState() {
    var email = Modular.args.data;
    _emailEC.text = email;
    Future.delayed(
      Duration.zero,
      () => widget.controller.validateEmail(email, context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Language().translation(context);
    return PopScope(
      canPop: Modular.to.canPop(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: height,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/sign_in_background.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(.70),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: height * 0.10),
                            Container(
                              height: width * .1,
                              width: width * .13,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/coffee_cup.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: height * .03),
                            Text(
                              lang.forgotPassword,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: width * .06,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * .04),
                            Text(
                              lang.enterEmailAddress,
                              style: TextStyle(color: AppColors.greyLight, fontSize: width * .035),
                            ),
                            SizedBox(height: height * .04),
                            Text(
                              lang.afterReceivingPassword,
                              style: TextStyle(color: AppColors.greyLight, fontSize: width * .035),
                            ),
                            SizedBox(height: height * .04),
                          ],
                        ),
                        Observer(
                          builder: (context) {
                            return Column(
                              children: [
                                TextFieldWidget(
                                  height: height * .03,
                                  hintText: lang.emailAddress,
                                  controller: _emailEC,
                                  onChanged: (_) => widget.controller.validateEmail(
                                    _emailEC.text,
                                    context,
                                  ),
                                  validator: (_) => _validators.emailValidator(_emailEC.text, context),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: height * .02),
                                ButtonWidget(
                                  onPressed: widget.controller.emailValid
                                      ? () => widget.controller.recoverPassword(_emailEC.text, context)
                                      : null,
                                  titleButton: lang.sendEmail,
                                ),
                                SizedBox(height: height * .02),
                                InkWell(
                                  onTap: () => Modular.to.pop(),
                                  child: Row(
                                    children: [
                                      Text(
                                        lang.rememberedPassword,
                                        style: TextStyle(
                                          color: AppColors.greyLight,
                                          fontSize: width * .03,
                                        ),
                                      ),
                                      SizedBox(width: width * .02),
                                      Text(
                                        lang.loginYourAccount,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                          fontSize: width * .03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * .04),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

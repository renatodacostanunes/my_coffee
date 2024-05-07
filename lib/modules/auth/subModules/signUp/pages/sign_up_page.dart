import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';
import 'package:my_coffee/core/shared/widgets/button_widget.dart';
import 'package:my_coffee/core/shared/widgets/social_media_login_widget.dart';
import 'package:my_coffee/core/shared/widgets/text_field_widget.dart';
import 'package:my_coffee/core/styles/colors.dart';
import 'package:my_coffee/locale/language.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/controllers/sign_up_controller.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/models/register_account_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final controller = Modular.get<SignUpController>();
  final validators = Validators();
  final emailEC = TextEditingController();
  final fullNameEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void validateFields() {
    controller.validateAllFilds(
      fullName: fullNameEC.text,
      emailAddress: emailEC.text,
      password: passwordEC.text,
      confirmPassword: confirmPasswordEC.text,
    );
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        lang.registerAccount,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: width * .06,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * .04),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * .05),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFieldWidget(
                                hintText: lang.fullName,
                                controller: fullNameEC,
                                onChanged: (_) => validateFields(),
                                validator: (_) => validators.fullNameValidator(fullNameEC.text),
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(height: height * .02),
                              TextFieldWidget(
                                hintText: lang.emailAddress,
                                controller: emailEC,
                                onChanged: (_) => validateFields(),
                                validator: (_) => validators.emailValidator(emailEC.text),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: height * .02),
                              TextFieldWidget(
                                hintText: lang.password,
                                controller: passwordEC,
                                onChanged: (_) => validateFields(),
                                validator: (_) => validators.passwordValidator(passwordEC.text),
                              ),
                              SizedBox(height: height * .02),
                              TextFieldWidget(
                                hintText: lang.password,
                                controller: confirmPasswordEC,
                                onChanged: (_) => validateFields(),
                                validator: (_) => validators.confirmPasswordValidator(
                                  password: passwordEC.text,
                                  confirmPassword: confirmPasswordEC.text,
                                ),
                              ),
                              SizedBox(height: height * .03),
                              Observer(
                                builder: (_) {
                                  return ButtonWidget(
                                    onPressed: controller.validFilds
                                        ? () async {
                                            var registerAccountModel = RegisterAccountModel(
                                              fullName: fullNameEC.text,
                                              emailAddress: emailEC.text,
                                              password: passwordEC.text,
                                            );
                                            await controller.registerAccount(registerAccountModel, context);
                                          }
                                        : null,
                                    titleButton: lang.register,
                                    onLongPress: controller.validFilds
                                        ? () async {
                                            var registerAccountModel = RegisterAccountModel(
                                              fullName: fullNameEC.text,
                                              emailAddress: emailEC.text,
                                              password: passwordEC.text,
                                            );
                                            await controller.registerAccount(registerAccountModel, context, true);
                                          }
                                        : null,
                                  );
                                },
                              ),
                              SizedBox(height: height * .06),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: AppColors.primary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Text(
                              lang.registerWith,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: width * .035,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * .04),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * .05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SocialMediaLoginWidget(
                              image: "assets/images/facebook_logo.png",
                              onTap: () {},
                            ),
                            SocialMediaLoginWidget(
                              image: "assets/images/google_logo.png",
                              onTap: () {},
                            ),
                            SocialMediaLoginWidget(
                              image: "assets/images/twitter_logo.png",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * .1, bottom: height * .03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lang.alreadyAccount,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: width * .035,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2),
                            InkWell(
                              onTap: () => Modular.to.pushNamedAndRemoveUntil(
                                AppRoutes.auth + AppRoutes.signIn,
                                (_) => false,
                              ),
                              child: Text(
                                lang.login,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: width * .035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * .04),
                    ],
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

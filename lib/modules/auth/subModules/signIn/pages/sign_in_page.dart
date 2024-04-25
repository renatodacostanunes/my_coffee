import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_coffee/core/consts/app_routes.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/shared/utils/validators.dart';
import 'package:my_coffee/core/shared/widgets/button_widget.dart';
import 'package:my_coffee/core/shared/widgets/social_media_login_widget.dart';
import 'package:my_coffee/core/shared/widgets/text_field_widget.dart';
import 'package:my_coffee/core/styles/colors.dart';
import 'package:my_coffee/locale/language.dart';
import 'package:my_coffee/modules/auth/subModules/signIn/controllers/sign_in_controller.dart';
import 'package:my_coffee/modules/auth/subModules/signUp/models/register_account_model.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  // TODO: Salvar o e-mail do usuário e preencher o formfield.
  // TODO: Habilitar botão após validar pelo menos e-mail e senha isNotEmpty
  final controller = Modular.get<SignInController>();
  RegisterAccountModel? arguments = Modular.args.data;
  late TextEditingController emailEC;
  final passwordEC = TextEditingController();
  final validators = Validators();

  @override
  Widget build(BuildContext context) {
    final lang = Language().translation(context);
    emailEC = TextEditingController(text: arguments?.emailAddress ?? "");
    return PopScope(
      canPop: false,
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
                        lang.welcomelogin,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: width * .06,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * .04),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * .05),
                        child: Column(
                          children: [
                            TextFieldWidget(
                              hintText: lang.emailAddress,
                              controller: emailEC,
                              validator: (_) => validators.emailValidator(emailEC.text),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: height * .02),
                            TextFieldWidget(
                              hintText: lang.password,
                              controller: passwordEC,
                            ),
                            SizedBox(height: height * .01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  lang.forgotPassword,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    fontSize: width * .03,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .03),
                            ButtonWidget(
                              onPressed: () async => await controller.login(emailEC.text, passwordEC.text, context),
                              onLongPress: () async =>
                                  await controller.login(emailEC.text, passwordEC.text, context, true),
                              titleButton: lang.signIn,
                            ),
                            SizedBox(height: height * .06),
                          ],
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
                              lang.loginWith,
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
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lang.haveAccount,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: width * .035,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 2),
                          InkWell(
                            onTap: () {
                              Modular.to.pushReplacementNamed(AppRoutes.auth + AppRoutes.signUp);
                            },
                            child: Text(
                              lang.register,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: width * .035,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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

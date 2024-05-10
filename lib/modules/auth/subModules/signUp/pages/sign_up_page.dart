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
  final _controller = Modular.get<SignUpController>();
  final _validators = Validators();
  final _emailEC = TextEditingController();
  final _fullNameEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validateFields() {
    _controller.validateAllFilds(
      fullName: _fullNameEC.text,
      emailAddress: _emailEC.text,
      password: _passwordEC.text,
      confirmPassword: _confirmPasswordEC.text,
      context: context,
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
                          key: _formKey,
                          child: Observer(
                            builder: (context) {
                              return Column(
                                children: [
                                  TextFieldWidget(
                                    height: height * .03,
                                    autofocus: true,
                                    hintText: lang.fullName,
                                    controller: _fullNameEC,
                                    onChanged: (_) => validateFields(),
                                    validator: (_) => _validators.fullNameValidator(_fullNameEC.text, context),
                                    keyboardType: TextInputType.name,
                                  ),
                                  SizedBox(height: height * .02),
                                  TextFieldWidget(
                                    height: height * .03,
                                    hintText: lang.emailAddress,
                                    controller: _emailEC,
                                    onChanged: (_) => validateFields(),
                                    validator: (_) => _validators.emailValidator(_emailEC.text, context),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: height * .02),
                                  TextFieldWidget(
                                    height: height * .03,
                                    obscureText: _controller.passwordVisible,
                                    suffixIcon: IconButton(
                                      onPressed: () => _controller.passwordVisible = !_controller.passwordVisible,
                                      icon: Icon(
                                        _controller.passwordVisible ? Icons.visibility : Icons.visibility_off,
                                        size: height * 0.04,
                                      ),
                                    ),
                                    hintText: lang.password,
                                    controller: _passwordEC,
                                    onChanged: (_) => validateFields(),
                                    validator: (_) => _validators.passwordValidator(_passwordEC.text, context),
                                  ),
                                  SizedBox(height: height * .02),
                                  TextFieldWidget(
                                    height: height * .03,
                                    obscureText: _controller.confirmPasswordVisible,
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          _controller.confirmPasswordVisible = !_controller.confirmPasswordVisible,
                                      icon: Icon(
                                        _controller.confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                        size: height * 0.04,
                                      ),
                                    ),
                                    hintText: lang.confirmPassword,
                                    controller: _confirmPasswordEC,
                                    onChanged: (_) => validateFields(),
                                    validator: (_) => _validators.confirmPasswordValidator(
                                      password: _passwordEC.text,
                                      confirmPassword: _confirmPasswordEC.text,
                                      context: context,
                                    ),
                                  ),
                                  SizedBox(height: height * .03),
                                  Observer(
                                    builder: (_) {
                                      return ButtonWidget(
                                        onPressed: _controller.validFilds
                                            ? () async {
                                                var registerAccountModel = RegisterAccountModel(
                                                  fullName: _fullNameEC.text,
                                                  emailAddress: _emailEC.text,
                                                  password: _passwordEC.text,
                                                );
                                                await _controller.registerAccount(registerAccountModel, context);
                                              }
                                            : null,
                                        titleButton: lang.register,
                                        onLongPress: _controller.validFilds
                                            ? () async {
                                                var registerAccountModel = RegisterAccountModel(
                                                  fullName: _fullNameEC.text,
                                                  emailAddress: _emailEC.text,
                                                  password: _passwordEC.text,
                                                );
                                                await _controller.registerAccount(registerAccountModel, context, true);
                                              }
                                            : null,
                                      );
                                    },
                                  ),
                                  SizedBox(height: height * .06),
                                ],
                              );
                            },
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

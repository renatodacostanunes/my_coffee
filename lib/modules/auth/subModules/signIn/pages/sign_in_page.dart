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
import 'package:my_coffee/modules/auth/subModules/signIn/controllers/sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final _controller = Modular.get<SignInController>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _validators = Validators();

  void validateFields() {
    _controller.validateAllFilds(
      emailAddress: _emailEC.text,
      password: _passwordEC.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Language().translation(context);
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
                              height: height * .03,
                              hintText: lang.emailAddress,
                              controller: _emailEC,
                              onChanged: (_) => validateFields(),
                              validator: (_) => _validators.emailValidator(_emailEC.text, context),
                              keyboardType: TextInputType.emailAddress,
                              suffixIcon: FutureBuilder(
                                future: _controller.setEmail(_emailEC),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Container(
                                      margin: EdgeInsets.only(right: width * 0.03),
                                      height: height * 0.05,
                                      width: height * 0.05,
                                      child: const CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: height * 0.04,
                                    ),
                                    onPressed: _controller.emailsRegistered!.isNotEmpty
                                        ? () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => StatefulBuilder(
                                                builder: (_, setState) {
                                                  return Dialog(
                                                    alignment: const Alignment(1, -0.5),
                                                    insetPadding: EdgeInsets.symmetric(
                                                        horizontal: width * .05, vertical: height * .1),
                                                    shape: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: const BorderSide(color: Colors.transparent)),
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: _controller.emailsRegistered!
                                                            .map(
                                                              (email) => PopupMenuItem(
                                                                padding: EdgeInsets.only(left: width * .045),
                                                                onTap: () async {
                                                                  _emailEC.text = email;
                                                                  await _controller.saveLastSelectedEmail(email);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child: Text(
                                                                        email,
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      padding: EdgeInsets.zero,
                                                                      onPressed: () async {
                                                                        await _controller.removeRegisteredAccount(
                                                                          email,
                                                                          _emailEC,
                                                                        );
                                                                        setState(() {});
                                                                      },
                                                                      icon: const Icon(
                                                                        Icons.delete_forever,
                                                                        color: AppColors.red,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        : null,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: height * .02),
                            Observer(
                              builder: (context) {
                                return TextFieldWidget(
                                  height: height * .03,
                                  onChanged: (_) => validateFields(),
                                  hintText: lang.password,
                                  controller: _passwordEC,
                                  obscureText: _controller.passwordVisible,
                                  suffixIcon: IconButton(
                                    onPressed: () => _controller.passwordVisible = !_controller.passwordVisible,
                                    icon: Icon(
                                      _controller.passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      size: height * 0.04,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: height * .01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () => Modular.to.pushNamed(
                                    AppRoutes.auth + AppRoutes.recoverPassword,
                                    arguments: _emailEC.text,
                                  ),
                                  child: Text(
                                    lang.forgotPassword,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                      fontSize: width * .03,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .03),
                            Observer(
                              builder: (context) {
                                return ButtonWidget(
                                  onPressed: _controller.validFilds
                                      ? () async => await _controller.login(_emailEC.text, _passwordEC.text, context)
                                      : null,
                                  onLongPress: _controller.validFilds
                                      ? () async =>
                                          await _controller.login(_emailEC.text, _passwordEC.text, context, true)
                                      : null,
                                  titleButton: lang.signIn,
                                );
                              },
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
                              onTap: () async {
                                await _controller.signInWithFacebook(context);
                              },
                            ),
                            SocialMediaLoginWidget(
                              image: "assets/images/google_logo.png",
                              onTap: () async {
                                await _controller.signInWithGoogle(context);
                              },
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
                              Modular.to.pushNamed(AppRoutes.auth + AppRoutes.signUp);
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

import 'package:campaign_application/apis/api.dart';
import 'package:campaign_application/apis/api_manager.dart';
import 'package:campaign_application/auth_services/auth_service.dart';
import 'package:campaign_application/screens/authentication/bloc/auth_bloc.dart';
import 'package:campaign_application/screens/authentication/login_page.dart';
import 'package:campaign_application/screens/home_page/home_page.dart';
import 'package:campaign_application/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../themes/theme.dart';

class SignupPage extends StatefulWidget {
  static const String rootName = 'signupPage';

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _pass1isHidden = true;
  bool _pass2isHidden = true;
  var logger = Logger();
  AuthBloc authBloc = AuthBloc();

  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionableState,
      buildWhen: (previous, current) => current is! AuthActionableState,
      listener: (context, state) {
        if (state is NavigateToHome) {
          Navigator.pushReplacementNamed(context, HomePage.rootName);
        } else if (state is NavigateToLogin) {
          Navigator.pushReplacementNamed(context, LoginPage.rootName);
        } else if (state is AuthSuccess) {
          showSnackbar(context, message: state.message);
        } else if (state is AuthError) {
          showSnackbar(context, message: state.message);
        }
      },
      builder: (context, state) {
        return AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    heightBox(size.height * 0.2),
                    Padding(
                      padding: const EdgeInsets.all(padding10),
                      child: Text(
                        "Let's you sign in",
                        style: kCustomTextStyle(blackColor, padding25, true),
                      ),
                    ),
                    heightBox(padding40),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: padding20,
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        cursorColor: blackColor,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        style: kCustomTextStyle(blackColor, padding15, false),
                        decoration: kInputDecoGradient(
                          "email",
                          "eg.xxxx@gmail.com",
                        ),
                      ),
                    ),
                    heightBox(padding30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: padding20 * 1.2,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        cursorColor: blackColor,
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.text,
                        obscureText: _pass1isHidden,
                        obscuringCharacter: '*',
                        style: kTextStyleCustomSubText(
                          blackColor,
                          padding14,
                          false,
                        ),
                        decoration: kInputDecoGradientPassword(
                          'Password',
                          '***************',
                          _pass1isHidden,
                          () {
                            setState(() {
                              _pass1isHidden = !_pass1isHidden;
                            });
                          },
                        ),
                      ),
                    ),
                    heightBox(padding30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: padding20 * 1.2,
                      ),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        cursorColor: blackColor,
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.text,
                        obscureText: _pass2isHidden,
                        obscuringCharacter: '*',
                        style: kTextStyleCustomSubText(
                          blackColor,
                          padding14,
                          false,
                        ),
                        decoration: kInputDecoGradientPassword(
                          'Confirm Password',
                          '***************',
                          _pass2isHidden,
                          () {
                            setState(() {
                              _pass2isHidden = !_pass2isHidden;
                            });
                          },
                        ),
                      ),
                    ),
                    heightBox(padding30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: padding20 * 1.2,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty &&
                                _confirmPasswordController.text.isNotEmpty) {
                              if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                final String email =
                                    _emailController.text.trim();
                                final String password =
                                    _passwordController.text.trim();
                                authBloc.add(
                                  SignUpEvent(email: email, password: password),
                                );
                              } else {
                                showSnackbar(
                                  context,
                                  message:
                                      "Password does not matched. Kindly re-enter confirm password",
                                );
                              }
                            } else {
                              showSnackbar(
                                context,
                                message: "Kindly enter all fields!",
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blackColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Sign in',
                            style: kCustomTextStyle(
                              Colors.white,
                              padding18,
                              true,
                            ),
                          ),
                        ),
                      ),
                    ),
                    heightBox(padding20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          LoginPage.rootName,
                        );
                      },
                      child: Text(
                        "Already have an account. Kindly login here.",
                      ),
                    ),
                    heightBox(padding20),
                    ElevatedButton(
                      onPressed: () {
                        authBloc.add(GoogleSignInEvent());
                      },
                      child: Text("Sign in with Google"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

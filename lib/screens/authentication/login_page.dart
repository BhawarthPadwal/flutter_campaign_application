import 'package:campaign_application/screens/authentication/bloc/auth_bloc.dart';
import 'package:campaign_application/screens/authentication/signup_page.dart';
import 'package:campaign_application/screens/home_page/home_page.dart';
import 'package:campaign_application/themes/theme.dart';
import 'package:campaign_application/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatefulWidget {
  static const String rootName = 'loginPage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHidden = true;
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
            // backgroundColor: blackColor,
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
                        obscureText: _isHidden,
                        obscuringCharacter: '*',
                        style: kTextStyleCustomSubText(
                          blackColor,
                          padding14,
                          false,
                        ),
                        decoration: kInputDecoGradientPassword(
                          'Password',
                          '***************',
                          _isHidden,
                          () {
                            setState(() {
                              _isHidden = !_isHidden;
                            });
                          },
                        ),
                        onChanged: (value) {},
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
                                _passwordController.text.isNotEmpty) {
                              final String email = _emailController.text.trim();
                              final String password =
                                  _passwordController.text.trim();
                              authBloc.add(
                                SignInEvent(email: email, password: password),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Kindly enter all fields!"),
                                ),
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
                            'Login',
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
                        Navigator.pushNamed(context, SignupPage.rootName);
                      },
                      child: Text(
                        "Don't have an account. Kindly create account.",
                      ),
                    ),
                    heightBox(padding20),
                    ElevatedButton(
                      onPressed: () async {
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
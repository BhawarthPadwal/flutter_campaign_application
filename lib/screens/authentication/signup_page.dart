import 'package:campaign_application/auth_services/auth_service.dart';
import 'package:campaign_application/screens/authentication/login_page.dart';
import 'package:campaign_application/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        // backgroundColor: blackColor,
        body: SafeArea(
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
                padding: const EdgeInsets.symmetric(horizontal: padding20),
                child: TextFormField(
                  controller: _emailController,
                  cursorColor: blackColor,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: kCustomTextStyle(blackColor, padding15, false),
                  decoration: kInputDecoGradient("email", "eg.xxxx@gmail.com"),
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
                  style: kTextStyleCustomSubText(blackColor, padding14, false),
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
                  onChanged: (value) {
                    // handle clearing error here if needed
                  },
                  // validator: (value) => ...
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
                  style: kTextStyleCustomSubText(blackColor, padding14, false),
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
                  onChanged: (value) {
                    // handle clearing error here if needed
                  },
                  // validator: (value) => ...
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
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _confirmPasswordController.text.isNotEmpty) {
                        if (_passwordController.text ==
                            _confirmPasswordController.text) {
                          try {
                            bool isSignedUp = await AuthService().signup(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (isSignedUp) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Signup successful! Please log in.")),
                              );
                              Navigator.pushReplacementNamed(
                                  context, LoginPage.rootName);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Signup failed. Please try again.")),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Error: ${e.toString()}")),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Password does not matched. Kindly re-enter confirm password")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Kindly enter all fields!")));
                      }
                      // Navigator.pushReplacementNamed(context, LoginScreen.rootName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blackColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Sign in',
                      style: kCustomTextStyle(Colors.white, padding18, true),
                    ),
                  ),
                ),
              ),
              heightBox(padding20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, LoginPage.rootName);
                },
                child: Text("Already have an account. Kindly login here."),
              ),
              heightBox(padding20),
              ElevatedButton(
                onPressed: () async {
                  final userCredential = await AuthService().signInWithGoogle();
                  if (userCredential != null) {
                    // User signed in successfully
                    print('Signed in: ${userCredential.user!.email}');
                    logger.i('Signed in: ${userCredential.user!.email}');
                    Navigator.pushReplacementNamed(context, HomePage.rootName);
                  } else {
                    // Sign-in failed or was canceled
                    print('Sign-in cancelled or failed');
                    logger.e('Sign-in cancelled or failed');
                  }
                },
                child: Text("Sign in with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

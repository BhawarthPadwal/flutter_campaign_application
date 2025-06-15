import 'package:campaign_application/apis/api_manager.dart';
import 'package:campaign_application/screens/authentication/signup_page.dart';
import 'package:campaign_application/screens/home_page/home_page.dart';
import 'package:campaign_application/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:campaign_application/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../apis/app_req.dart';

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
                  padding: const EdgeInsets.symmetric(horizontal: padding20),
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
                            _passwordController.text.isNotEmpty) {
                          try {
                            bool isSignedIn = await AuthService().signin(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            if (isSignedIn) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Logged in successfully!"),
                                ),
                              );
                              Navigator.pushReplacementNamed(
                                context,
                                HomePage.rootName,
                              );
                              /*String? uid =
                                    FirebaseAuth.instance.currentUser?.uid;

                                if (uid != null) {
                                  bool exists = await isUserExistsInDB(uid);

                                  if (!exists) {
                                    // Create user if not found
                                    await ApiManager.post(
                                      AppReqEndPoint.createUser(),
                                      {
                                        "userId": uid,
                                        "emailId":
                                            _emailController.text.toString(),
                                      },
                                    );
                                    logger.i("User created in DB.");
                                  } else {
                                    logger.i("User already exists in DB.");
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Logged in successfully!"),
                                    ),
                                  );

                                  Navigator.pushReplacementNamed(
                                    context,
                                    HomePage.rootName,
                                  );
                                } else {
                                  logger.e("Firebase UID is null.");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("User ID not found."),
                                    ),
                                  );
                                }*/
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Signin failed. Please try again.",
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            logger.e("Login error: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Kindly enter all fields!"),
                            ),
                          );
                        }
                      },
                      /*if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          try {
                            bool isSignedIn = await AuthService().signin(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (isSignedIn) {
                              String? uid =
                                  FirebaseAuth.instance.currentUser?.uid;
                              await isUserExistsInDB == true ?
                               : ;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Logged in successfully!"),
                                ),
                              );
                              ApiManager.post(AppReqEndPoint.createUser(), {
                                "userId": uid,
                                "emailId": _emailController.text.toString(),
                              });
                              Navigator.pushReplacementNamed(
                                context,
                                HomePage.rootName,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Signin failed. Please try again.",
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Kindly enter all fields!"),
                            ),
                          );
                        }*/
                      //Navigator.pushReplacementNamed(context, SportOptions.rootName);
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: kCustomTextStyle(Colors.white, padding18, true),
                      ),
                    ),
                  ),
                ),
                heightBox(padding20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignupPage.rootName);
                  },
                  child: Text("Don't have an account. Kindly create account."),
                ),
                heightBox(padding20),
                ElevatedButton(
                  /*onPressed: () async {
                    final userCredential =
                        await AuthService().signInWithGoogle();
                    if (userCredential != null) {
                      // User signed in successfully
                      print('Logged in: ${userCredential.user!.email}');
                      logger.i('Logged in: ${userCredential.user!.email}');
                      Navigator.pushReplacementNamed(
                        context,
                        HomePage.rootName,
                      );
                      // Navigate to home or another page
                    } else {
                      // Sign-in failed or was canceled
                      print('Log-in cancelled or failed');
                      logger.e('Log-in cancelled or failed');
                    }
                  },*/
                    onPressed: () async {
                      final userCredential = await AuthService().signInWithGoogle();
                      if (userCredential != null) {
                        String? uid = userCredential.user?.uid;
                        String? email = userCredential.user?.email;

                        if (uid != null && email != null) {
                          bool exists = await ApiManager.isUserExistsInDB(uid);

                          if (!exists) {
                            await ApiManager.post(
                              AppReqEndPoint.createUser(),
                              {"userId": uid, "emailId": email},
                            );
                            logger.i("Google user created in DB.");
                          } else {
                            logger.i("Google user already exists in DB.");
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Signed in successfully!"),
                            ),
                          );

                          Navigator.pushReplacementNamed(context, HomePage.rootName);
                        } else {
                          logger.e("Google Sign-In failed: UID or email is null");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Google Sign-In failed."),
                            ),
                          );
                        }
                      } else {
                        logger.e("Google Sign-In cancelled or failed");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Google Sign-In cancelled or failed."),
                          ),
                        );
                      }
                    },
                    child: Text("Sign in with Google"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*Future<bool> isUserExistsInDB(String uid) async {
  try {
    final response = await ApiManager.get(AppReqEndPoint.getUserById(uid));
    if (response['status'] == 200) {
      return true;
    } else if (response['status'] == 404) {
      return false;
    }
  } catch (e) {
    print(e);
  }
  return false;
}*/

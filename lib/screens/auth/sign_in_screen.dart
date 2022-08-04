import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/screens/home/home_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await auth.signInWithCredential(credential)).user;

      debugPrint('Signed User Name: ${user?.displayName}');

      return user;
    } catch (e) {
      debugPrint('Signup Error: ${e.toString()}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/food_app_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Sign in to continue',
                  ),
                  Text(
                    'Foodie',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      shadows: [
                        BoxShadow(
                          color: Colors.green.shade900,
                          blurRadius: 5,
                          offset: const Offset(3, 3),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SignInButton(
                        Buttons.Facebook,
                        text: "Sign in with Facebook",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 5),
                      (defaultTargetPlatform != TargetPlatform.iOS)
                          ? SignInButton(
                              Buttons.Google,
                              text: "Sign in with Google",
                              onPressed: () {
                                _googleSignUp().then(
                                  (value) =>
                                      Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(),
                      const SizedBox(height: 5),
                      (defaultTargetPlatform != TargetPlatform.android)
                          ? SignInButton(
                              Buttons.Apple,
                              text: "Sign in with Apple",
                              onPressed: () {},
                            )
                          : Container(),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'By sign in you are agree to our',
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              debugPrint('Terms Button Clicked');
                            },
                            child: Text(
                              'Terms',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'and',
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              debugPrint('Privacy Policy Button Clicked');
                            },
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

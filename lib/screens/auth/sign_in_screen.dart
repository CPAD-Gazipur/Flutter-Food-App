import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_food_app/providers/providers.dart';
import 'package:flutter_food_app/screens/home/home_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  late UserProvider userProvider;
  AccessToken? _accessToken;
  Map<String, dynamic>? _userData;

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

      if (user != null) {
        userProvider.addUserData(
          currentUser: user,
          userName: user.displayName!,
          userEmail: user.email!,
          userImage: user.photoURL!,
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('Signup Error: Password is Weak');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('Signup Error: This email already in used');
      } else if (e.code == 'user-not-found') {
        debugPrint('Signup Error: User not found');
      } else if (e.code == 'wrong-password') {
        debugPrint('Signup Error: Wrong Password');
      }
      return null;
    } catch (e) {
      debugPrint('Signup Error: ${e.toString()}');
      return null;
    }
  }

  _facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      debugPrint('$_userData');
    } else {
      debugPrint('${result.status}');
      debugPrint('${result.message}');
    }
  }

  _emailPasswordSignUpAndLogin() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  Text('LOGIN'),
                  Text('SIGN UP'),
                  Text('THIS FEATURE IS ON DEVELOPMENT'),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
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
            SizedBox(
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
                        Buttons.Email,
                        text: 'Sign in with Email',
                        onPressed: () {
                          _emailPasswordSignUpAndLogin();
                        },
                      ),
                      const SizedBox(height: 5),
                      SignInButton(
                        Buttons.Facebook,
                        text: "Sign in with Facebook",
                        onPressed: () {
                          _facebookLogin();
                        },
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

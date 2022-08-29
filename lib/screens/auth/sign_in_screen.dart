import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/providers/providers.dart';
import 'package:flutter_food_app/screens/home/home_screen.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
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
  bool isLogin = true;
  bool isPasswordVisible = true;

  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  final _formSignUpKey = GlobalKey<FormState>();
  final _formLoginUpKey = GlobalKey<FormState>();

  TextEditingController nameSignUpController = TextEditingController();
  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();

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
          uID: user.uid,
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
            child: StatefulBuilder(builder: (context, setState) {
              return Container(
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
                          child: Container(
                            color: isLogin
                                ? const Color(0xFFF1EFEF)
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLogin = true;
                                });
                              },
                              child: const Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: isLogin
                                ? Colors.white
                                : const Color(0xFFF1EFEF),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: const Center(
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 5.0,
                      ),
                      child: isLogin
                          ? Form(
                              key: _formLoginUpKey,
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  CustomTextField(
                                    controller: emailLoginController,
                                    hintText: 'Ex.. example@gmail.com',
                                    labelText: 'Email Address',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (String? value) {
                                      if (value == '') {
                                        return 'Email address is required';
                                      } else if (!value!.contains('@')) {
                                        return 'Enter valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: isPasswordVisible,
                                    controller: passwordLoginController,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (String? value) {
                                      if (value == '') {
                                        return 'Password is required';
                                      } else if (value!.length < 6) {
                                        return 'Password must be 6 digit long';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Roboto',
                                      ),
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                    ),
                                    onPressed: () {
                                      if (!_formLoginUpKey.currentState!
                                          .validate()) {
                                        return;
                                      } else {
                                        _loginUsingEmailAndPassword().then(
                                          (value) => Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen(),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Form(
                              key: _formSignUpKey,
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  CustomTextField(
                                    controller: nameSignUpController,
                                    hintText: 'Ex.. Md. Al-Amin',
                                    labelText: 'Your Name',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (String? value) {
                                      if (value == '') {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    controller: emailSignUpController,
                                    hintText: 'Ex.. example@gmail.com',
                                    labelText: 'Email Address',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (String? value) {
                                      if (value == '') {
                                        return 'Email address is required';
                                      } else if (!value!.contains('@')) {
                                        return 'Enter valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: isPasswordVisible,
                                    controller: passwordSignUpController,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (String? value) {
                                      if (value == '') {
                                        return 'Password is required';
                                      } else if (value!.length < 6) {
                                        return 'Password must be 6 digit long';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter password',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Roboto',
                                      ),
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                    ),
                                    onPressed: () {
                                      if (!_formSignUpKey.currentState!
                                          .validate()) {
                                        return;
                                      } else {
                                        _signUpUsingEmailAndPassword().then(
                                          (value) => Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen(),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }

  Future<User?> _signUpUsingEmailAndPassword() async {
    EasyLoading.show(status: 'Creating account...');

    // try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailSignUpController.text,
      password: passwordSignUpController.text,
    )
        .catchError((e) {
      debugPrint('$e');
      EasyLoading.showError('$e');
    });

    EasyLoading.dismiss();

    debugPrint('${credential.user}');

    final User? user = credential.user;

    debugPrint('Signed User Name: ${user?.displayName}');

    if (user != null) {
      userProvider.addUserData(
        uID: user.uid,
        userName: nameSignUpController.text,
        userEmail: emailSignUpController.text,
        userImage: user.photoURL ?? '',
      );
    } else {
      userProvider.addUserData(
        uID: user!.uid,
        userName: nameSignUpController.text,
        userEmail: emailSignUpController.text,
        userImage: user.photoURL ?? '',
      );
    }

    nameSignUpController.text = '';
    emailSignUpController.text = '';
    passwordSignUpController.text = '';

    EasyLoading.dismiss();

    return credential.user;
    /*// } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
      EasyLoading.dismiss();
      return null;
    } catch (e) {
      debugPrint('$e');
      EasyLoading.dismiss();
      return null;
    }*/
  }

  Future<User?> _loginUsingEmailAndPassword() async {
    EasyLoading.show(status: 'Login...');

    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailLoginController.text,
            password: passwordLoginController.text,
          )
          .then((value) => value.user)
          .catchError((e) {
        EasyLoading.dismiss();
        debugPrint('$e');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else {
        debugPrint(e.toString());
      }
      EasyLoading.dismiss();
      return null;
    }
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

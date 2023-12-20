import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toolist/screens/start_screen/signup_page.dart';

import '/screens/main_screen/dashboard.dart';
import '/utils/validator.dart';
import '/utils/fire_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  bool _isVisible = true;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Dashboard(user: user),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Form(
                  key: _loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Log In',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 13),
                      Center(
                        child: Text(
                          'Fill this form with your account',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 39),
                      Container(
                        margin: const EdgeInsets.only(left: 105),
                        child: Text(
                          'Email',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 96),
                        child: TextFormField(
                          controller: _emailTextController,
                          focusNode: _focusEmail,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              Validator.validateEmail(email: value),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Put your Email down here...',
                              hintStyle: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      const SizedBox(height: 21),
                      Container(
                        margin: const EdgeInsets.only(left: 105),
                        child: Text(
                          'Password',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 96),
                        child: TextFormField(
                          controller: _passwordTextController,
                          focusNode: _focusPassword,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              Validator.validatePassword(password: value),
                          obscureText: _isVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isVisible = !_isVisible;
                                    });
                                  }),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Put your password down here...',
                              hintStyle: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      const SizedBox(height: 39),
                      _isProcessing
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black))
                          : Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      fixedSize: const Size(130, 40)),
                                  onPressed: () async {
                                    _focusEmail.unfocus();
                                    _focusPassword.unfocus();

                                    if (_loginFormKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      User? user = await FireAuth.signInAccount(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text);

                                      setState(() {
                                        _isProcessing = false;
                                      });

                                      if (user != null) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Dashboard(user: user)),
                                            (Route<dynamic> route) => false);
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Log In',
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin:
                                    const EdgeInsets.only(left: 45, right: 20),
                                child: const Divider(color: Colors.black)),
                          ),
                          Text(
                            'OR',
                            style: GoogleFonts.lato(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 45),
                                child: const Divider(color: Colors.black)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 29),
                      Center(
                        child: TextButton(
                          child: Text(
                            'Sign up with your email',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                        ),
                      )
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }),
      ),
    );
  }
}

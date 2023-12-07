import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/screens/start_screen/verify_page.dart';
import '/utils/fire_auth.dart';
import '/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isVisible = true;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 13),
                Text(
                  'Fill Up These Form Below To Create Your Account',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 39),
                Container(
                  padding: const EdgeInsets.only(right: 227),
                  child: Text(
                    'Full Name',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 96, right: 96),
                  child: TextFormField(
                    controller: _fullName,
                    focusNode: _focusName,
                    keyboardType: TextInputType.text,
                    validator: (value) => Validator.validateName(name: value),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'The Full Name goes here....',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        )),
                  ),
                ),
                const SizedBox(height: 21),
                Container(
                  padding: const EdgeInsets.only(right: 251),
                  child: Text(
                    'Email',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 96, right: 96),
                  child: TextFormField(
                    controller: _email,
                    focusNode: _focusEmail,
                    keyboardType: TextInputType.text,
                    validator: (value) => Validator.validateEmail(email: value),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Put your Email down here...',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        )),
                  ),
                ),
                const SizedBox(height: 21),
                Container(
                  padding: const EdgeInsets.only(right: 225),
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
                  padding: const EdgeInsets.only(left: 96, right: 96),
                  child: TextFormField(
                    controller: _password,
                    focusNode: _focusPassword,
                    keyboardType: TextInputType.text,
                    obscureText: _isVisible,
                    validator: (value) =>
                        Validator.validatePassword(password: value),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Create your password here...',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        )),
                  ),
                ),
                const SizedBox(height: 39),
                _isProcessing
                    ? const CircularProgressIndicator(color: Colors.black)
                    : Container(
                        padding: const EdgeInsets.only(left: 160, right: 160),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(255, 255, 255, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                fixedSize: const Size(130, 40)),
                            onPressed: () async {
                              setState(() {
                                _isProcessing = true;
                              });

                              if (_registerFormKey.currentState!.validate()) {
                                User? user = await FireAuth.registerAccount(
                                    name: _fullName.text,
                                    image: '-',
                                    email: _email.text,
                                    password: _password.text);
                                setState(() {
                                  _isProcessing = false;
                                });

                                if (user != null) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VerifyPage(user: user),
                                      ),
                                      ModalRoute.withName('/'));
                                }
                              }
                            },
                            child: Text(
                              'Sign Up',
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
                          margin: const EdgeInsets.only(left: 45, right: 20),
                          child: const Divider(color: Colors.black)),
                    ),
                    Text(
                      'OR',
                      style: GoogleFonts.lato(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 45),
                          child: const Divider(color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(height: 29),
                TextButton(
                  child: Text(
                    'Already have an account?',
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('login_page');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

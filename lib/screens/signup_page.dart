import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _fullName = TextEditingController();
  String _gender = 'Male';
  String _profilePicture = '-';
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Padding(
              padding: const EdgeInsets.only(left: 96, right: 96),
              child: TextField(
                controller: _fullName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Full Name',
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
            const SizedBox(height: 29),
            Padding(
              padding: const EdgeInsets.only(left: 96, right: 96),
              child: TextField(
                controller: _fullName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Male',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    )),
              ),
            ),
            const SizedBox(height: 29),
            Padding(
              padding: const EdgeInsets.only(left: 96, right: 96),
              child: TextField(
                controller: _fullName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: '.png / .jpeg / .jpg',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    )),
              ),
            ),
            const SizedBox(height: 29),
            Padding(
              padding: const EdgeInsets.only(left: 96, right: 96),
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.text,
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
            const SizedBox(height: 29),
            Padding(
              padding: const EdgeInsets.only(left: 96, right: 96),
              child: TextField(
                controller: _password,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
    );
  }
}

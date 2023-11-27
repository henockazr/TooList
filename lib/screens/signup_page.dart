import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toolist/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _fullName = TextEditingController();
  String _gender = 'Male';
  // String _profilePicture = '-';
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _isVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Container(
                padding: const EdgeInsets.only(left: 104),
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
              const SizedBox(height: 29),
              Container(
                padding: const EdgeInsets.only(left: 104),
                child: Text(
                  'Gender',
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
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          filled: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintStyle: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          )),
                      value: _gender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList())),
              const SizedBox(height: 29),
              Container(
                padding: const EdgeInsets.only(left: 104),
                child: Text(
                  'Profile Picture',
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
              Container(
                padding: const EdgeInsets.only(left: 104),
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
              const SizedBox(height: 29),
              Container(
                padding: const EdgeInsets.only(left: 104),
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
                  keyboardType: TextInputType.text,
                  obscureText: _isVisible,
                  validator: (value) =>
                      Validator.validatePassword(password: value),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isVisible ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
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
              Container(
                padding: const EdgeInsets.only(left: 160, right: 160),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        fixedSize: const Size(130, 40)),
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

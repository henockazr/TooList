import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_screen/dashboard.dart';
import '/utils/fire_auth.dart';

class VerifyPage extends StatefulWidget {
  final User user;

  const VerifyPage({super.key, required this.user});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool _isSendingVerification = false;

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Verify Your Email\nBefore Continue',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              '${_currentUser.email}',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 31),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Status : ',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _currentUser.emailVerified
                    ? Text(
                        'Verified',
                        style: GoogleFonts.lato(
                            color: const Color(0xFF34A853),
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      )
                    : Text('Unverified',
                        style: GoogleFonts.lato(
                            color: const Color(0xFFEA4335),
                            fontSize: 15,
                            fontWeight: FontWeight.w700))
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isSendingVerification
                    ? const CircularProgressIndicator(color: Colors.black)
                    : ElevatedButton(
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
                            _isSendingVerification = true;
                          });
                          await _currentUser.sendEmailVerification();
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: Text(
                          'Verify Email',
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )),
                const SizedBox(width: 11),
                IconButton(
                    icon: const Icon(Icons.refresh),
                    splashRadius: 20,
                    onPressed: () async {
                      User? user = await FireAuth.refreshUser(_currentUser);
                      if (user != null) {
                        setState(() {
                          _currentUser = user;
                        });
                      }
                      if (_currentUser.emailVerified == true && user != null) {
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => Dashboard(user: user),
                              ),
                              ModalRoute.withName('/'));
                        });
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}

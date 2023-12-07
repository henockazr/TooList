import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/screens/main_screen/profile/edit_profile.dart';
import '/screens/start_screen/landing_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _currentUser;
  bool _isSigningOut = false;
  String image = '-';

  // Future pickImage(String id) async {
  //   try {
  //     var picked = await FilePicker.platform.pickFiles(withData: true);

  //     if (picked != null) {
  //       FireAuth.updateImage(image: image);
  //     }
  //   } on PlatformException catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  // @override
  // void initState() {
  //   _currentUser = widget.user;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile',
              style:
                  GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 48),
            const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 60,
              // backgroundImage: NetworkImage(_currentUser.photoURL!),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right: 36),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Edit',
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward,
                        size: 15, color: Colors.black)
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => EditProfile(user: _currentUser)));
                },
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.black,
              indent: 24,
              endIndent: 24,
            ),
            const SizedBox(height: 78),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: Text(
                        'Name',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 270),
                      child: Text(
                        'Randy Panglila',
                        // '${_currentUser.displayName}',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: Text(
                        'Email',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 200),
                      child: Text(
                        'randypanglila@gmail.com',
                        // '${_currentUser.email}',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 78),
            const Divider(
              color: Colors.black,
              indent: 24,
              endIndent: 24,
            ),
            const SizedBox(height: 43),
            _isSigningOut
                ? const CircularProgressIndicator(color: Colors.black)
                : Container(
                    padding: const EdgeInsets.only(left: 160, right: 160),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFFEA4335),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            fixedSize: const Size(200, 40)),
                        onPressed: () async {
                          setState(() {
                            _isSigningOut = true;
                          });
                          await FirebaseAuth.instance.signOut();
                          setState(() {
                            _isSigningOut = false;
                          });
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LandingPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.inter(
                              color: const Color(0xFFEA4335),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )),
                  )
          ],
        ),
      ),
    );
  }
}

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

  @override
  void initState() {
    _currentUser = FirebaseAuth.instance.currentUser!;
    super.initState();
  }

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
            _currentUser.photoURL ==
                    'https://drive.google.com/file/d/1nLtNU3MfMUsjgaPKUXJ-r8uNX8If2Kvz/view?usp=sharing'
                ? const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 60,
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage('${_currentUser.photoURL}'),
                    radius: 60,
                  ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  TextButton(
                    child: Row(
                      children: [
                        Text(
                          'Edit',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.arrow_forward,
                            size: 15, color: Colors.black)
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.black,
              indent: 24,
              endIndent: 24,
            ),
            const SizedBox(height: 78),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      _currentUser.displayName == null
                          ? Text(
                              'Please Insert Display Name',
                              style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            )
                          : Text(
                              '${_currentUser.displayName}',
                              style: GoogleFonts.lato(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_currentUser.email}',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
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
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            fixedSize: const Size(200, 40)),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                title: const Text("WARNING"),
                                content:
                                    const Text("Are you sure want to log out?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      //Close Dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                          width: 2,
                                          color: Colors.red,
                                        ),
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
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
                                          builder: (context) =>
                                              const LandingPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Log Out",
                                      style: GoogleFonts.inter(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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

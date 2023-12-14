import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/fire_auth.dart';

class EditProfile extends StatefulWidget {
  final User user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late User _currentUser;
  bool _isSigningOut = false;

  final _registerFormKey = GlobalKey<FormState>();

  String image = '-';
  final _fullName = TextEditingController();
  final _email = TextEditingController();

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
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('TooList',
            style:
                GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFEAF2FF),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Profile',
            style:
                GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 48),
          // const CircleAvatar(
          //   backgroundColor: Colors.black,
          //   radius: 60,
          //   // backgroundImage: NetworkImage(_currentUser.photoURL!),
          // ),
          const SizedBox(height: 35),
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
                  Text(
                    'Name',
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Rendy Panglila',
                    ),
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.w500),
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
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'rendy@gmial.com',
                    ),
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.w500),
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
          Container(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xFF000000),
                  ),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  FireAuth.updateAccount(
                      name: _fullName.text, image: image, email: _email.text);

                  Navigator.pop(context, true);
                },
                child: Text(
                  'Save',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF000000),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )),
          )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/fire_auth.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late User _currentUser;

  String image = '';
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
    _currentUser = FirebaseAuth.instance.currentUser!;
    image = _currentUser.photoURL!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_left_rounded)),
        centerTitle: true,
        elevation: 0,
        title: Text('TooList',
            style:
                GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFEAF2FF),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Profile',
            style:
                GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 48),
          _currentUser.photoURL == null
              ? const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 60,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 60,
                ),
          const SizedBox(height: 35),
          const Divider(
            color: Colors.black,
            indent: 24,
            endIndent: 24,
          ),
          const SizedBox(height: 78),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text(
                        'Name',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _fullName,
                        decoration: InputDecoration(
                          hintText: '${_currentUser.displayName}',
                        ),
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text(
                        'Email',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: '${_currentUser.email}',
                        ),
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )),
              const SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    FireAuth.updateAccount(
                        name: _fullName.text,
                        image:
                            'https://drive.google.com/file/d/1nLtNU3MfMUsjgaPKUXJ-r8uNX8If2Kvz/view?usp=sharing',
                        email: _email.text);
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    'Save',
                    style: GoogleFonts.inter(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

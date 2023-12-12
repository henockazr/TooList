import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.fromLTRB(43, 30, 43, 26),
            decoration: ShapeDecoration(
                color: const Color(0xFFEAF2FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Halo, ',
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'Rendy Panglila',
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total Expenses',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Rp 154.000',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    const SizedBox(width: 32),
                    Column(
                      children: [
                        Text(
                          'To Dos Left',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '5 Task',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  "Today's Task",
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 9),
                Text('Saturday, 25 November 2023',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      height: 0,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 23),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushNamed('add_todo');
                  },
                  child: Row(
                    children: [
                      Text(
                        'New To Do',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.add, color: Colors.black)
                    ],
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushNamed('add_budget');
                  },
                  child: Row(
                    children: [
                      Text(
                        'New Expenses',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.add, color: Colors.black)
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}

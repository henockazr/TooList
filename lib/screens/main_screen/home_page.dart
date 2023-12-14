import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toolist/utils/config.dart';
import 'package:toolist/utils/models/budget_model.dart';
import 'package:toolist/utils/models/todo_model.dart';
import 'package:toolist/utils/restapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataService ds = DataService();

  List data = [];
  List<ToDoListModel> toDo = [];
  List<BudgetTrackerListModel> budget = [];

  selectAllToDo() async {
    data =
        jsonDecode(await ds.selectAll(token, project, 'manajemen_aset', appid));

    toDo = data.map((e) => ToDoListModel.fromJson(e)).toList();

    //Refresh the UI
    setState(() {
      toDo = toDo;
    });
  }

  @override
  void initState() {
    selectAllToDo();

    super.initState();
  }

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 40.0),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Halo, ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'Rendy Panglila',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 19),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Expenses',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Rp 154.000',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To Dos Left',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '5 Task',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
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
                    ),
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
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      // Implement logic for New Expenses button
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To Do List',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement functionality for the "More" button
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'More ',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 15,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 17),
              Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCarouselCard(
                        'Tugas Akhir ISB - 311',
                        'Milestone $index / Sprint $index tugas akhir ISB - 311',
                      );
                    }),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Budget Tracker',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement functionality for the "More" button
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'More ',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 15,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCarouselCard(
                        'Daily Expenses',
                        'Pengeluaran ke - $index pada minggu ke - $index',
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCarouselCard(String title, String description) {
    return Container(
      width: 400,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: SizedBox(
          width: 400,
          height: 175,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBudgetlCard(String title, String description) {
    return Container(
      width: 400,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: SizedBox(
          width: 400,
          height: 175,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

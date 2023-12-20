import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toolist/screens/todo/todo_add.dart';
import 'package:toolist/screens/budget/budget_add_page.dart';
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
  late User _currentUser;
  DataService ds = DataService();
  DateTime now = DateTime.now();

  List dataBudget = [];
  List dataToDo = [];
  int totalExpenses = 0;
  int totalToDo = 0;
  List<ToDoListModel> todoFiltered = [];
  List<BudgetListModel> budgetFiltered = [];

  selectToDoFiltered() async {
    dataToDo = jsonDecode(await ds.selectWhere(
        token, project, toDoList, appid, 'status', 'To Do'));

    todoFiltered = dataToDo.map((e) => ToDoListModel.fromJson(e)).toList();

    setState(() {
      todoFiltered = todoFiltered;
    });
  }

  selectBudgetFiltered() async {
    String formattedDate = DateFormat.yMMMMd('en_US').format(now);

    dataBudget = jsonDecode(await ds.selectWhere(
        token, project, budgetList, appid, 'date_budget', formattedDate));

    budgetFiltered =
        dataBudget.map((e) => BudgetListModel.fromJson(e)).toList();

    //Refresh the UI
    setState(() {
      budgetFiltered = budgetFiltered;
    });
  }

  Future reloadDataAset(dynamic value) async {
    setState(() {
      selectBudgetFiltered();
      selectToDoFiltered();
    });
  }

  @override
  void initState() {
    selectBudgetFiltered();
    selectToDoFiltered();
    _currentUser = FirebaseAuth.instance.currentUser!;
    super.initState();
  }

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMEEEEd('en_US').format(now);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hi, ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        _currentUser.displayName == null
                            ? const Text(
                                'there !',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Text(
                                '${_currentUser.displayName}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today Expenses',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Rp 154.000',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic),
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
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '5 Task',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Have something to write?",
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
<<<<<<< HEAD
                  const SizedBox(height: 9),
                  Text(formattedDate,
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(18),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.black,
=======
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

>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b
                      ),
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TodoAddPage()));
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
                    ),
                  ),
<<<<<<< HEAD
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(18),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.black,
=======
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
>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b
                      ),
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BudgetAddPage()));
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
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'To Do List',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'More ',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 15,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              dataToDo.isEmpty
                  ? const SizedBox(
                      height: 150,
                      child: Center(
                          child: Text(
                        'You have nothing do do :)',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )),
                    )
                  : SizedBox(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: todoFiltered.length,
                          itemBuilder: (context, index) {
                            final item = todoFiltered[index];
                            return InkWell(
                              borderRadius: BorderRadius.circular(30),
                              child: buildToDoCard(
                                  item.title, item.description, item.deadline),
                              onTap: () {
                                Navigator.pushNamed(context, 'todo_edit',
                                    arguments: [item.id]).then(reloadDataAset);
                              },
                            );
                          }),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Budget Tracker',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pushNamed('list_budget');
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
                        const Icon(
                          Icons.arrow_forward,
                          size: 15,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
<<<<<<< HEAD
              const SizedBox(height: 10),
              dataBudget.isEmpty
                  ? const SizedBox(
                      height: 125,
                      child: Center(
                          child: Text(
                        'You have no expenses for today ?',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )),
                    )
                  : SizedBox(
                      height: 125,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: budgetFiltered.length,
                          itemBuilder: (context, index) {
                            final item = budgetFiltered[index];
                            return InkWell(
                                borderRadius: BorderRadius.circular(30),
                                child: budgetCard(item.title_budget,
                                    item.amount, item.date_budget),
                                onTap: () {
                                  Navigator.pushNamed(context, 'budget_edit',
                                          arguments: [item.id])
                                      .then(reloadDataAset);
                                });
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildToDoCard(String title, String description, String deadline) {
    return SizedBox(
      height: 150,
      width: 220,
      child: Card(
        elevation: 0,
        color: const Color(0xFFEAF2FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                    fontSize: 15, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style:
                    GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                deadline,
                style:
                    GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w500),
=======
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
>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b
              ),
            ],
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget budgetCard(String title, String amount, String date) {
    return SizedBox(
      height: 125,
      width: 205,
      child: Card(
        elevation: 0,
        color: const Color(0xFFEAF2FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                    fontSize: 15, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Rp $amount',
                style:
                    GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                date,
                style:
                    GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w500),
=======
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
>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b
              ),
            ],
          ),
        ),
      ),
    );
  }
}

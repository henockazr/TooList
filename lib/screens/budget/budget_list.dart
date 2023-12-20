import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toolist/utils/config.dart';
import 'package:toolist/utils/models/budget_model.dart';
import 'package:toolist/utils/restapi.dart';

class BudgetListPage extends StatefulWidget {
  const BudgetListPage({Key? key}) : super(key: key);

  @override
  BudgetListPageState createState() => BudgetListPageState();
}

class BudgetListPageState extends State<BudgetListPage> {
  DataService ds = DataService();

  List dataBudget = [];
  List<BudgetListModel> budget = [];

  selectAllAset() async {
    dataBudget =
        jsonDecode(await ds.selectAll(token, project, budgetList, appid));

    budget = dataBudget.map((e) => BudgetListModel.fromJson(e)).toList();

    //Refresh the UI
    setState(() {
      budget = budget;
    });
  }

  Future reloadDataAset(dynamic value) async {
    setState(() {
      selectAllAset();
    });
  }

  @override
  void initState() {
    selectAllAset();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budget Tracker',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 13),
                Text(
                  'This Week',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Rp. 222.000.00',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  textAlign:
                      TextAlign.left, // Mengatur teks menjadi di sebelah kiri
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.585,
                  child: ListView.builder(
                    itemCount: budget.length,
                    itemBuilder: (context, index) {
                      final item = budget[index];
                      return Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                            child: budgetListCard(item.title_budget,
                                item.amount, item.category, item.date_budget),
                            onTap: () {
                              Navigator.pushNamed(context, 'budget_edit',
                                  arguments: [item.id]).then(reloadDataAset);
                            }),
                      );
                    },
<<<<<<< HEAD
                  ),
                ),
=======
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.task, color: Colors.blue),
                              SizedBox(width: 6),
                              Text('Lunch at Cafetaria'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp. 25,000',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Food',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '25 November 2023',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.task, color: Colors.blue),
                              SizedBox(width: 6),
                              Text('Lunch at Cafetaria'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp. 25,000',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Food',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '25 November 2023',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.task, color: Colors.blue),
                              SizedBox(width: 6),
                              Text('Lunch at Cafetaria'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp. 25,000',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Food',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '22 November 2023',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.task, color: Colors.blue),
                              SizedBox(width: 6),
                              Text('Lunch at Cafetaria'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp. 25,000',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Food',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '25 November 2023',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.task, color: Colors.blue),
                              SizedBox(width: 6),
                              Text('Lunch at Cafetaria'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp. 25,000',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Food',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '25 November 2023',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget budgetListCard(
      String title, String amount, String category, String date) {
    return Card(
      elevation: 0,
      shape: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.task, color: Colors.black),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp $amount',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

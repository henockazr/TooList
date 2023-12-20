import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toolist/utils/config.dart';
import 'package:toolist/utils/models/budget_model.dart';
import 'package:toolist/utils/restapi.dart';

class BudgetEdit extends StatefulWidget {
  const BudgetEdit({super.key});

  @override
  State<BudgetEdit> createState() => _BudgetEditState();
}

class _BudgetEditState extends State<BudgetEdit> {
  final title = TextEditingController();
  final amount = TextEditingController();
  final date = TextEditingController();
  final description = TextEditingController();
  String category = 'Personal';
  String updateId = '';
  bool loadData = false;
  late Future<DateTime?> selectedDate;

  DataService ds = DataService();

  List<BudgetListModel> budget = [];

  selectIdAset(String id) async {
    List data = [];
    data = jsonDecode(await ds.selectId(token, project, budgetList, appid, id));
    budget = data.map((e) => BudgetListModel.fromJson(e)).toList();

    setState(() {
      title.text = budget[0].title_budget;
      date.text = budget[0].date_budget;
      amount.text = budget[0].amount;
      description.text = budget[0].desc;
      category = budget[0].category;
      updateId = budget[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;

    if (loadData == false) {
      selectIdAset(args[0]);

      loadData = true;
    }
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text('TooList',
              style:
                  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
          backgroundColor: const Color(0xFFEAF2FF),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Edit To Do Notes',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: title,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Put The Notes Title Here....',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 19),
                    Text(
                      'Date Create',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 33),
                    Flexible(
                      child: TextField(
                        controller: date,
                        keyboardType: TextInputType.datetime,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Expenses's Date...",
                            hintStyle: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        onTap: () {
                          showDialogPicker(context, date.text);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.attach_money),
                    const SizedBox(width: 19),
                    Text(
                      'Amount',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 58),
                    Flexible(
                      child: TextFormField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input Your Expenses...',
                            hintStyle: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.description),
                    const SizedBox(width: 19),
                    Text(
                      'Desciption',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 41),
                    Flexible(
                      child: TextFormField(
                        controller: description,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Put Your Description Here...',
                            hintStyle: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.category),
                    const SizedBox(width: 19),
                    Text(
                      'Category',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 51),
                    Flexible(
                      child: DropdownButtonFormField(
                        value: category,
                        onChanged: (String? value) {
                          setState(() {
                            category = value!;
                          });
                        },
                        items: <String>[
                          'Hobbies',
                          'Personal',
                          'Food & Bev',
                          'Transportation',
                          'Other'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Category',
                          hintStyle: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
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
                            fixedSize: const Size(130, 40)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          fixedSize: const Size(130, 40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Save',
                            style: GoogleFonts.inter(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.check_rounded,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        bool response = await ds.updateId(
                            'title_budget~date_budget~amount~desc~category',
                            '${title.text}~${amount.text}~${description.text}~$category~${date.text}',
                            token,
                            project,
                            budgetList,
                            appid,
                            updateId);

                        if (response) {
                          Navigator.pop(context, true);
                        } else {
                          if (kDebugMode) {
                            print(response);
                          }
                        }
                      },
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                title: const Text("WARNING"),
                                content: const Text(
                                    "Are you sure want to remove this data?"),
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
                                      // Close Dialog
                                      bool response = await ds.removeId(token,
                                          project, budgetList, appid, args[0]);
                                      Navigator.of(context).pop();

                                      if (response) {
                                        Navigator.pop(context, true);
                                      }
                                    },
                                    child: Text(
                                      "Delete",
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
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogPicker(BuildContext context, String currentDate) {
    DateTime initialDate;
    if (currentDate == '') {
      initialDate = DateTime.now();
    } else {
      var inputFormat = DateFormat('dd-MM-yyyy');
      initialDate = inputFormat.parse(currentDate);
    }

    selectedDate = showDatePicker(
      context: context,
      initialDate:
          DateTime(initialDate.year, initialDate.month, initialDate.day),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    selectedDate.then((value) {
      setState(() {
        //prevent error when null clode
        if (value == null) return;

        final DateFormat formatter = DateFormat.yMMMMd('en_US');
        final String formattedDate = formatter.format(value);
        date.text = formattedDate;
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}

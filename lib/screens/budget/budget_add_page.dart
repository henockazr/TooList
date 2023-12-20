import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toolist/utils/config.dart';
import 'package:toolist/utils/models/budget_model.dart';
import 'package:toolist/utils/restapi.dart';

class BudgetAddPage extends StatefulWidget {
  const BudgetAddPage({super.key});

  @override
  _BudgetAddPageState createState() => _BudgetAddPageState();
}

<<<<<<< HEAD
class _BudgetAddPageState extends State<BudgetAddPage> {
  final title = TextEditingController();
  final amount = TextEditingController();
  final date = TextEditingController();
  final description = TextEditingController();
  String category = 'Personal';

  DataService ds = DataService();

  late Future<DateTime?> selectedDate;
=======
class _BudgetPageState extends State<BudgetPage> {
  final _registerFormKey = GlobalKey<FormState>();
  String selectedCategory = 'Food';
  final _notesTitle = TextEditingController();

  final _focusTitle = FocusNode();
  DateTime? dueDate;
  bool _isVisible = true;
>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b

  @override
  Widget build(BuildContext context) {
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
<<<<<<< HEAD
                  'Create Your Budget Notes !',
=======
                  'CREATE YOUR BUDGET NOTES !',
>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
<<<<<<< HEAD
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
                          showDialogPicker(context);
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
                TextButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        width: 2,
                        color: Colors.black,
=======
                const SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 96),
                  child: TextFormField(
                    controller: _notesTitle,
                    focusNode: _focusTitle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Put The Notes Title Here....',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                const SizedBox(height: 39),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 96),
                  child: TextFormField(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      ).then((pickedDate) {
                        if (pickedDate != null && pickedDate != dueDate) {
                          setState(() {
                            dueDate = pickedDate;
                          });
                        }
                      });
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        hintText: dueDate != null
                            ? "${dueDate!.toLocal()}".split(' ')[0]
                            : "Date Create",
                        hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                const SizedBox(height: 39),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 96),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        hintText: 'Input Your expenses',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                const SizedBox(height: 39),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 96),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        hintText: 'Put Your Description here...',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                const SizedBox(height: 39),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 96),
                  child: DropdownButtonFormField(
                    value: selectedCategory,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: <String>['Food', 'Bensin', 'Lainnya']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.category),
                      hintText: 'Category',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        width: 2,
                        color: Colors.black,
>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b
                      ),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      fixedSize: const Size(130, 40)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
<<<<<<< HEAD
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check_rounded,
=======
                      Icon(
                        Icons.check,
>>>>>>> 0507a8d3521d4dbc2e7a670b395d5ec5c8166f7b
                        color: Colors.black,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    List response = jsonDecode(await ds.insertBudgetList(
                        appid,
                        title.text,
                        amount.text,
                        description.text,
                        category,
                        date.text));
                    List<BudgetListModel> budget = response
                        .map((e) => BudgetListModel.fromJson(e))
                        .toList();

                    if (budget.length == 1) {
                      Navigator.pop(context, true);
                    } else {
                      if (kDebugMode) {
                        print(response);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogPicker(BuildContext context) {
    var tanggal = DateTime.now();

    selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime(tanggal.year, tanggal.month, tanggal.day),
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    selectedDate.then((value) {
      setState(() {
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

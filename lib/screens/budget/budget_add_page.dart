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

class _BudgetAddPageState extends State<BudgetAddPage> {
  final title = TextEditingController();
  final amount = TextEditingController();
  final date = TextEditingController();
  final description = TextEditingController();
  String category = 'Personal';

  DataService ds = DataService();

  late Future<DateTime?> selectedDate;

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
                  'Create Your Budget Notes !',
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
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check_rounded,
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

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toolist/utils/config.dart';
import 'package:toolist/utils/models/todo_model.dart';
import 'package:toolist/utils/restapi.dart';

class TodoAddPage extends StatefulWidget {
  const TodoAddPage({super.key});

  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  final title = TextEditingController();
  final description = TextEditingController();
  final date = TextEditingController();
  final deadline = TextEditingController();
  String status = 'To Do';
  String priority = 'Medium';

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
                  'Create Your To Do Notes !',
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
                      child: TextFormField(
                        controller: date,
                        onTap: () {
                          dialogDate(context);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "To Do's Date...",
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
                    const Icon(Icons.alarm),
                    const SizedBox(width: 19),
                    Text(
                      'Due Date',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    Flexible(
                      child: TextFormField(
                        controller: deadline,
                        onTap: () {
                          dialogDeadline(context);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "The Deadline...",
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
                    const Icon(Icons.priority_high),
                    const SizedBox(width: 19),
                    Text(
                      'Priority',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 62),
                    Flexible(
                      child: DropdownButtonFormField(
                        value: priority,
                        onChanged: (String? value) {
                          setState(() {
                            priority = value!;
                          });
                        },
                        items: <String>['High', 'Medium', 'Low']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.my_library_books),
                    const SizedBox(width: 19),
                    Text(
                      'Status',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 69),
                    Flexible(
                      child: DropdownButtonFormField(
                        value: status,
                        onChanged: (String? value) {
                          setState(() {
                            status = value!;
                          });
                        },
                        items: <String>['To Do', 'Doing', 'Done']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
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
                    List respone = jsonDecode(await ds.insertToDoList(
                        appid,
                        title.text,
                        date.text,
                        deadline.text,
                        description.text,
                        priority,
                        status));
                    List<ToDoListModel> todo =
                        respone.map((e) => ToDoListModel.fromJson(e)).toList();

                    if (todo.length == 1) {
                      Navigator.pop(context, true);
                    } else {
                      if (kDebugMode) {
                        print(respone);
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

  void dialogDate(BuildContext context) {
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

  void dialogDeadline(BuildContext context) {
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
        deadline.text = formattedDate;
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}

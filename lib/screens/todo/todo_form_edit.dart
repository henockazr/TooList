import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toolist/utils/config.dart';
import 'package:toolist/utils/models/todo_model.dart';
import 'package:toolist/utils/restapi.dart';

class ToDoEdit extends StatefulWidget {
  const ToDoEdit({super.key});

  @override
  State<ToDoEdit> createState() => _ToDoEditState();
}

class _ToDoEditState extends State<ToDoEdit> {
  final title = TextEditingController();
  final date = TextEditingController();
  final deadline = TextEditingController();
  final description = TextEditingController();
  String priority = 'High';
  String status = 'To Do';
  String updateId = '';
  bool loadData = false;
  late Future<DateTime?> selectedDate;

  DataService ds = DataService();

  List<ToDoListModel> todo = [];

  selectIdAset(String id) async {
    List data = [];
    data = jsonDecode(await ds.selectId(token, project, toDoList, appid, id));
    todo = data.map((e) => ToDoListModel.fromJson(e)).toList();

    setState(() {
      title.text = todo[0].title;
      date.text = todo[0].date;
      deadline.text = todo[0].deadline;
      description.text = todo[0].description;
      priority = todo[0].priority;
      status = todo[0].status;
      updateId = todo[0].id;
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
                            hintText: "To Do's Date...",
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
                    const Icon(Icons.alarm),
                    const SizedBox(width: 19),
                    Text(
                      'Due Date',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    Flexible(
                      child: TextField(
                        controller: deadline,
                        keyboardType: TextInputType.datetime,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "The Deadline...",
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
                    const Icon(Icons.description),
                    const SizedBox(width: 19),
                    Text(
                      'Description',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 34),
                    Flexible(
                      child: TextFormField(
                        controller: description,
                        keyboardType: TextInputType.number,
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
                    const SizedBox(width: 60),
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
                          hintText: 'Priority',
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
                    const SizedBox(width: 64),
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
                          hintText: 'Status',
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
                            'title~date~deadline~description~priority~status',
                            '${title.text}~${date.text}~${deadline.text}~${description.text}~$priority~$status',
                            token,
                            project,
                            toDoList,
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
                                          project, toDoList, appid, args[0]);
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

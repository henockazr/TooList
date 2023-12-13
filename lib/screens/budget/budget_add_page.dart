import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final _registerFormKey = GlobalKey<FormState>();
  String selectedCategory = 'Food';
  final _notesTitle = TextEditingController();

  final _focusTitle = FocusNode();
  DateTime? dueDate;
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'CREATE YOUR BUDGET NOTES !',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
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
                      Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('signup_page');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

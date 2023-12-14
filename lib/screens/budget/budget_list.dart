// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:toolist/utils/models/budget_model.dart';
// import 'package:toolist/utils/restapi.dart';
// import 'package:toolist/utils/config.dart';

// class BudgetList extends StatefulWidget {
//   const BudgetList({Key? key}) : super(key: key);

//   @override
//   _BudgetListState createState() => _BudgetListState();
// }

// class _BudgetListState extends State<BudgetList> {
//   final searchKeyword = TextEditingController();

//   DataService ds = DataService();
//   List data = [];
//   List<BudgetTrackerListModel> budget = [];

//   // List<BudgetTrackerListModel> search_data = [];
//   // List<BudgetTrackerListModel> search_data_pre = [];

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           elevation: 0,
//           title: Text('TooList',
//               style:
//                   GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
//           backgroundColor: const Color(0xFFEAF2FF),
//           //search belum masuk
//         ),
//         body: ListView.builder(
//           itemCount: budget.length,
//           itemBuilder: (context, index) {
//             final item = budget[index];

//             return ListTile(
//               title: Text(item.title),
//               subtitle: Text(item.desription),
//             );
//           },
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:toolist/screens/budget/budget_add_page.dart';
import 'package:toolist/screens/budget/budget_list.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        floatingActionButton: SpeedDial(
          buttonSize: const Size(70, 70),
          childrenButtonSize: const Size(70, 70),
          backgroundColor: const Color(0xFFEAF2FF),
          animatedIcon: AnimatedIcons.add_event,
          children: [
            SpeedDialChild(
              labelBackgroundColor: const Color(0xFFEAF2FF),
              backgroundColor: const Color(0xFFEAF2FF),
              child: const Icon(Icons.monetization_on),
              label: 'Add Expenses',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BudgetAddPage()));
              },
            ),
            SpeedDialChild(
              labelBackgroundColor: const Color(0xFFEAF2FF),
              backgroundColor: const Color(0xFFEAF2FF),
              child: const Icon(Icons.task),
              label: 'Add To Do',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BudgetAddPage()));
              },
            ),
          ],
        ),
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'To Do List',
              ),
              Tab(
                text: 'Budget List',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("To Do List"),
            ),
            BudgetListPage()
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toolist/utils/config.dart';
import 'package:toolist/utils/models/budget_model.dart';
import 'package:toolist/utils/models/todo_model.dart';
import 'package:toolist/utils/restapi.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DataService ds = DataService();
  final searchKeyword = SearchController();

  List dataBudget = [];
  List<BudgetListModel> budget = [];
  List<BudgetListModel> search_data_budget = [];
  List<BudgetListModel> search_data_pre_budget = [];

  List dataToDo = [];
  List<ToDoListModel> todo = [];
  List<ToDoListModel> search_data_todo = [];
  List<ToDoListModel> search_data_pre_todo = [];

  int totalExpenses = 0;
  int totalToDo = 0;

  selectToDoFiltered() async {
    dataToDo = jsonDecode(await ds.selectAll(token, project, toDoList, appid));

    todo = dataToDo.map((e) => ToDoListModel.fromJson(e)).toList();

    setState(() {
      todo = todo;
    });
  }

  selectBudgetFiltered() async {
    dataBudget =
        jsonDecode(await ds.selectAll(token, project, budgetList, appid));

    budget = dataBudget.map((e) => BudgetListModel.fromJson(e)).toList();

    setState(() {
      budget = budget;
    });
  }

  void filterAset(String enteredKeyword) {
    search_data_pre_budget =
        dataBudget.map((e) => BudgetListModel.fromJson(e)).toList();
    search_data_budget = search_data_pre_budget
        .where((item) =>
            item.title_budget
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            item.date_budget
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            item.category.toLowerCase().contains(enteredKeyword.toLowerCase()))
        .toList();

    search_data_pre_todo =
        dataToDo.map((e) => ToDoListModel.fromJson(e)).toList();
    search_data_todo = search_data_pre_todo
        .where((item) =>
            item.title.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
            item.date.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
            item.status.toLowerCase().contains(enteredKeyword.toLowerCase()))
        .toList();

    setState(() {
      budget = search_data_budget;
      todo = search_data_todo;
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
    selectToDoFiltered();
    selectBudgetFiltered();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Scaffold(
            appBar: AppBar(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(50)),
                leading: const Icon(Icons.search),
                title: TextField(
                  controller: searchKeyword,
                  autofocus: true,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textInputAction: TextInputAction.search,
                  onChanged: (value) => filterAset(value),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search something...',
                    hintStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )),
            body: searchKeyword.text.isEmpty
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.question_mark_outlined,
                          size: 40, color: Colors.grey),
                      SizedBox(height: 15),
                      Text(
                        'Need something to search',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ))
                : Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount: todo.length,
                      itemBuilder: (context, index) {
                        final item = todo[index];
                        return ListTile(
                          title: Text(item.title),
                          subtitle: Text(item.deadline),
                          trailing: Text(item.date),
                          leading: Text(item.status),
                          onTap: () {
                            Navigator.pushNamed(context, 'budget_edit',
                                arguments: [item.id]).then(reloadDataAset);
                          },
                        );
                      },
                    ),
                  )));
  }
}

class BudgetListModel {
  final String id;
  final String title_budget;
  final String date_budget;
  final String amount;
  final String desc;
  final String category;

  BudgetListModel(
      {required this.id,
      required this.title_budget,
      required this.date_budget,
      required this.amount,
      required this.desc,
      required this.category});

  factory BudgetListModel.fromJson(Map data) {
    return BudgetListModel(
        id: data['_id'],
        title_budget: data['title_budget'],
        date_budget: data['date_budget'],
        amount: data['amount'],
        desc: data['desc'],
        category: data['category']);
  }
}

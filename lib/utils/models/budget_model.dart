class BudgetTrackerListModel {
  final String id;
  final String title;
  final String amount;
  final String desription;
  final String category;

  BudgetTrackerListModel(
      {required this.id,
      required this.title,
      required this.amount,
      required this.desription,
      required this.category});

  factory BudgetTrackerListModel.fromJson(Map<String, dynamic> data) {
    return BudgetTrackerListModel(
        id: data['_id'],
        title: data['title'],
        amount: data['amount'],
        desription: data['desription'],
        category: data['category']);
  }
}

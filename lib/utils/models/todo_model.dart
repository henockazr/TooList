class ToDoListModel {
  final String id;
  final String title;
  final String date;
  final String deadline;
  final String description;
  final String priority;
  final String status;

  ToDoListModel(
      {required this.id,
      required this.title,
      required this.date,
      required this.deadline,
      required this.description,
      required this.priority,
      required this.status});

  factory ToDoListModel.fromJson(Map<String, dynamic> data) {
    return ToDoListModel(
        id: data['_id'],
        title: data['title'],
        date: data['date'],
        deadline: data['deadline'],
        description: data['description'],
        priority: data['priority'],
        status: data['status']);
  }
}

import '../shared/enums.dart';

class Task {
  late String title;
  late String description;
  late String date;
  late Status status;

  Task({required this.title, required this.description, required this.date, required this.status});

  Status stringToStatus(String statusString) {
    return Status.values.firstWhere(
      (e) => e.toString().split('.').last == statusString,
      orElse: () => Status.undefined, // Handle default or undefined status
    );
  }

  Task.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    description = map['description'];
    date = map['date'];
    status = stringToStatus(map['status']);
  }

  String statusToString(Status status) {
    return status.toString().split('.').last; // Convert enum value to a string
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'status': statusToString(status),
    };
  }
}

import 'package:flutter_task_manager/app/models/tasks/TaskEntity.dart';

class Task {
  final int id;
  final String title;
  final int isCompleted;
  final String? dueDate;

  Task(this.id, this.title, this.isCompleted, {this.dueDate});

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isCompleted = json['is_completed'],
        dueDate = json['due_date'];

  TaskEntity toTaskEntity() {
    return TaskEntity(id, title, isCompleted, dueDate: dueDate);
  }
}

import 'dart:convert' as convert;

import 'package:flutter_task_manager/app/models/tasks/Task.dart';

class TaskEntity {
  final int id;
  final String title;
  final int isCompleted;
  final String? dueDate;
  final String? comments;
  final String? description;
  final String? tags;
  final String? token;
  final String? updatedAt;
  final String? createdAt;

  TaskEntity(this.id, this.title, this.isCompleted,
      {this.dueDate,
      this.comments,
      this.description,
      this.tags,
      this.token,
      this.updatedAt,
      this.createdAt});

  TaskEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isCompleted = json['is_completed'],
        dueDate = json['due_date'],
        comments = json['comments'],
        description = json['description'],
        tags = json['tags'],
        token = json['token'],
        updatedAt = json['updated_at'],
        createdAt = json['created_at'];

  TaskEntity.fromJsonPut(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isCompleted = int.parse(json['is_completed']),
        dueDate = json['due_date'],
        comments = json['comments'],
        description = json['description'],
        tags = json['tags'],
        token = json['token'],
        updatedAt = json['updated_at'],
        createdAt = json['created_at'];

  Task toTask() {
    return Task(id, title, isCompleted, dueDate: dueDate);
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token.toString(),
      "title": title.toString(),
      "is_completed": isCompleted,
      "due_date": dueDate.toString(),
      "comments": comments.toString(),
      "description": description.toString(),
      "tags": tags.toString(),
    };
  }

  @override
  String toString() {
    return convert.jsonEncode(this.toJson()).toString();
  }
}

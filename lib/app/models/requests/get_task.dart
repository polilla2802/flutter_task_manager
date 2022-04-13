import 'dart:convert' as convert;

class TaskRequest {
  final String? token;
  final String? title;
  final int? isCompleted;
  final String? dueDate;
  final String? comments;
  final String? description;
  final String? tags;

  TaskRequest(
      {this.title,
      this.isCompleted,
      this.dueDate,
      this.comments,
      this.description,
      this.tags,
      this.token});

  Map<String, dynamic> toJson() => {
        'token': token,
        'title': title,
        'is_completed': isCompleted,
        'due_date': dueDate,
        'comments': comments,
        'description': description,
        'tags': tags
      };

  @override
  String toString() {
    return convert.jsonEncode(toJson()).toString();
  }
}

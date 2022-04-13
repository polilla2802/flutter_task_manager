import 'dart:convert' as convert;

import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/exceptions/response.dart';
import 'package:flutter_task_manager/app/models/tasks/TaskEntity.dart';

class CreateTaskResponse {
  final String? detail;
  final TaskEntity? taskEntity;

  CreateTaskResponse({this.detail, this.taskEntity});

  static Result<CreateTaskResponse> fromJson(Map<String, dynamic> json) {
    try {
      final response = CreateTaskResponse(
          detail: json['detail'],
          taskEntity: TaskEntity.fromJson(json['task']));

      return Result.ok(response);
    } catch (e) {
      print("[CreateTaskResponse] " + "fromJson error: ${e.toString()}");
      return Result.fail(FailToParseResponseError(error: e.toString()));
    }
  }
}

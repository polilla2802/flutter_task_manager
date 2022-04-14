import 'dart:convert' as convert;

import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/exceptions/response.dart';
import 'package:flutter_task_manager/app/models/tasks/TaskEntity.dart';

class DeleteTaskResponse {
  final String? detail;

  DeleteTaskResponse({this.detail});

  static Result<DeleteTaskResponse> fromJson(Map<String, dynamic> json) {
    try {
      final response = DeleteTaskResponse(
        detail: json['detail'],
      );

      return Result.ok(response);
    } catch (e) {
      print("[DeleteTaskResponse] " + "fromJson error: ${e.toString()}");
      return Result.fail(FailToParseResponseError(error: e.toString()));
    }
  }
}

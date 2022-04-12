import 'package:flutter_task_manager/app/models/core/base_exception.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:flutter_task_manager/services/api/index.dart';

class TaskRepo {
  late TaskProvider _taskProvider;

  TaskRepo() {
    _taskProvider = TaskProvider();
  }

  Future<Result<String>> getAllTasks(String token) async {
    try {
      final ApiResult result = await _taskProvider.getAllTasks(token);

      if (result.hasData()) {
        print("task ${result.data}");
        return Result.ok(result.data);
      }

      if (result.isException()) {
        return Result.apiFail(result.exception);
      }

      return Result.ok(result.data);
    } catch (e) {
      return Result.fail(BaseException(true, error: e.toString()));
    }
  }
}

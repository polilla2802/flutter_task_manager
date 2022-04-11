import 'package:flutter_task_manager/app/models/core/base_exception.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:flutter_task_manager/services/api/index.dart';

class TaskRepo {
  late TaskProvider _taskProvider;

  TaskRepo() {
    this._taskProvider = TaskProvider();
  }

  Future<Result<String>> getAllTasks() async {
    try {
      final ApiResult result = await this._taskProvider.getAllTasks();

      if (result.hasData()) {}

      if (result.isException()) {
        Result.apiFail(result.exception);
      }

      return Result.ok(result.data);
    } catch (e) {
      return Result.fail(BaseException(true, error: e.toString()));
    }
  }
}

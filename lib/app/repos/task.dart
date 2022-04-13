import 'package:flutter_task_manager/app/models/core/base_exception.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/responses/create_task.dart';
import 'package:flutter_task_manager/app/models/responses/delete_task.dart';
import 'package:flutter_task_manager/app/models/responses/put_task.dart';
import 'package:flutter_task_manager/app/models/tasks/Task.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:flutter_task_manager/services/api/index.dart';

class TaskRepo {
  late TaskProvider _taskProvider;

  TaskRepo() {
    _taskProvider = TaskProvider();
  }

  Future<Result<List<Task>>> getAllTasksByToken(TaskArgs args) async {
    try {
      final ApiResult apiResult = await _taskProvider.getAllTasksByToken(args);

      if (apiResult.hasData()) {
        final rawList = apiResult.data as List<dynamic>;

        List<Task> finalList = rawList.map((e) => Task.fromJson(e)).toList();

        return Result.ok(finalList);
      }

      if (apiResult.isException()) {
        return Result.apiFail(apiResult.exception);
      }

      return Result.ok(apiResult.data);
    } catch (e) {
      return Result.fail(BaseException(true, error: e.toString()));
    }
  }

  Future<Result<CreateTaskResponse>> postTaskByToken(TaskArgs args) async {
    try {
      final ApiResult apiResult = await _taskProvider.postTaskByToken(args);

      if (apiResult.hasData()) {
        return CreateTaskResponse.fromJson(apiResult.data);
      }

      if (apiResult.isException()) {
        return Result.apiFail(apiResult.exception);
      }

      return CreateTaskResponse.fromJson(apiResult.data);
    } catch (e) {
      return Result.fail(BaseException(true, error: e.toString()));
    }
  }

  Future<Result<Task>> getTaskById(TaskArgs args) async {
    try {
      final ApiResult apiResult = await _taskProvider.getTaskById(args);

      if (apiResult.hasData()) {
        final result = Task.fromJson(apiResult.data);
        return Result.ok(result);
      }

      if (apiResult.isException()) {
        return Result.apiFail(apiResult.exception);
      }

      return Result.ok(apiResult.data);
    } catch (e) {
      return Result.fail(BaseException(true, error: e.toString()));
    }
  }

  Future<Result<PutTaskResponse>> putTaskById(TaskArgs args) async {
    try {
      final ApiResult apiResult = await _taskProvider.putTaskById(args);

      if (apiResult.hasData()) {
        return PutTaskResponse.fromJson(apiResult.data);
      }

      if (apiResult.isException()) {
        return Result.apiFail(apiResult.exception);
      }

      return PutTaskResponse.fromJson(apiResult.data);
    } catch (e) {
      return Result.fail(BaseException(true, error: e.toString()));
    }
  }

  Future<Result<DeleteTaskResponse>> deleteTaskById(TaskArgs args) async {
    try {
      final ApiResult apiResult = await _taskProvider.deleteTaskById(args);

      if (apiResult.hasData()) {
        return DeleteTaskResponse.fromJson(apiResult.data);
      }

      if (apiResult.isException()) {
        return Result.apiFail(apiResult.exception);
      }

      return DeleteTaskResponse.fromJson(apiResult.data);
    } catch (e) {
      return Result.fail(BaseException(true, error: e.toString()));
    }
  }
}

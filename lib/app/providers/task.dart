import 'package:flutter_task_manager/app/models/requests/get_task.dart';
import 'package:flutter_task_manager/services/api/index.dart';

class TaskArgs {
  TaskRequest? taskRequest;
  String? token;
  int? taskId;
  TaskArgs({this.taskRequest, this.token, this.taskId});
}

class TaskProvider {
  late API _api;

  TaskProvider() {
    _api = API();
  }

  Future<ApiResult> getAllTasksByToken(TaskArgs args) async {
    const String url = "/vdev/tasks-challenge/tasks";

    try {
      return await _api.get(ApiRequest(
          ApiChannel.nextline, "getAllTasksByToken", url, AuthType.bearer,
          queryParameters: {"token": args.token}));
    } catch (e) {
      return ApiResult(false);
    }
  }

  Future<ApiResult> postTaskByToken(TaskArgs args) async {
    var putBody = args.taskRequest!.toJson();
    const String url = "/vdev/tasks-challenge/tasks";

    try {
      return await _api.post(ApiRequest(
        ApiChannel.nextline,
        "postTaskByToken",
        url,
        AuthType.bearer,
        body: putBody,
      ));
    } catch (e) {
      return ApiResult(false);
    }
  }

  Future<ApiResult> getTaskById(TaskArgs args) async {
    const String url = "/vdev/tasks-challenge/tasks/task_id";

    try {
      return await _api.get(ApiRequest(
          ApiChannel.nextline, "getTaskById", url, AuthType.bearer,
          queryParameters: {"task_id": args.taskId.toString()}));
    } catch (e) {
      return ApiResult(false);
    }
  }

  Future<ApiResult> putTaskById(TaskArgs args) async {
    var putBody = args.taskRequest!.toJson();
    const String url = "/vdev/tasks-challenge/tasks/task_id";

    try {
      return await _api.put(ApiRequest(
        ApiChannel.nextline,
        "putTaskById",
        url,
        AuthType.bearer,
        body: putBody,
      ));
    } catch (e) {
      return ApiResult(false);
    }
  }

  Future<ApiResult> deleteTaskById(TaskArgs args) async {
    var putBody = {"token": args.token};
    const String url = "/vdev/tasks-challenge/tasks/task_id";

    try {
      return await _api.delete(ApiRequest(
          ApiChannel.nextline, "deleteTaskById", url, AuthType.bearer,
          body: putBody, queryParameters: {"task_id": args.taskId}));
    } catch (e) {
      return ApiResult(false);
    }
  }
}

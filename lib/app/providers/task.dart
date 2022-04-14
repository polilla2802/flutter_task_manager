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
    String url = "/vdev/tasks-challenge/tasks/${args.taskId}";

    try {
      return await _api.get(ApiRequest(
          ApiChannel.nextline, "getTaskById", url, AuthType.bearer,
          queryParameters: {"token": args.token.toString()}));
    } catch (e) {
      return ApiResult(false);
    }
  }

  Future<ApiResult> putTaskById(TaskArgs args) async {
    String url = "/vdev/tasks-challenge/tasks/${args.taskId}";

    try {
      return await _api.put(ApiRequest(
          ApiChannel.urlencoded, "putTaskById", url, AuthType.bearer,
          queryParameters: {
            "token": args.taskRequest!.token.toString(),
            "title": args.taskRequest!.title.toString(),
            "is_completed": args.taskRequest!.isCompleted.toString(),
            "due_date": args.taskRequest!.dueDate.toString() != null
                ? args.taskRequest!.dueDate.toString()
                : "2022-04-13",
            "comments": args.taskRequest!.comments.toString() != null
                ? args.taskRequest!.comments.toString()
                : "Sin comentarios",
            "description": args.taskRequest!.description.toString() != null
                ? args.taskRequest!.description.toString()
                : "Sin descripción",
            "tags": args.taskRequest!.tags.toString() != null
                ? args.taskRequest!.tags.toString()
                : "Sin Tags",
          }));
    } catch (e) {
      return ApiResult(false);
    }
  }

  Future<ApiResult> deleteTaskById(TaskArgs args) async {
    String url = "/vdev/tasks-challenge/tasks/${args.taskId}";

    try {
      return await _api.delete(ApiRequest(
          ApiChannel.nextline, "deleteTaskById", url, AuthType.bearer,
          queryParameters: {"token": args.token}));
    } catch (e) {
      return ApiResult(false);
    }
  }
}

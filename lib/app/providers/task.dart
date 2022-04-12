import 'package:flutter_task_manager/services/api/index.dart';

class TaskProvider {
  late API _api;

  TaskProvider() {
    _api = API();
  }

  Future<ApiResult> getAllTasks(String token) async {
    try {
      const String url = "/vdev/tasks-challenge/tasks";

      return await _api.get(ApiRequest(
          ApiChannel.nextline, "getAllTasks", url, AuthType.bearer,
          queryParameters: {"token": token}));
    } catch (e) {
      return ApiResult(false);
    }
  }
}

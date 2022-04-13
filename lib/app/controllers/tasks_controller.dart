import 'package:flutter/cupertino.dart';
import 'package:flutter_task_manager/app/models/core/controller_result.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/responses/create_task.dart';
import 'package:flutter_task_manager/app/models/tasks/Task.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:flutter_task_manager/app/repos/task.dart';

enum TasksException { loadingTasksFailure, undefined }

enum TasksState {
  /// The initial state loads the map for the first time, shows the title and subtitle.
  initial,

  /// The loading state is for the map when is loading, it shows a progrss indicator instead
  loading,

  /// The ready state is for the map when it finish loading and it's ready to be interacted with.
  noTasks,

  /// Everything is fine! :D yey!
  success,

  /// If something fails.
  error,
}

String getMainTaskStateKey(TasksState state) {
  switch (state) {
    case TasksState.initial:
      return "initial";
    case TasksState.loading:
      return "loading";
    case TasksState.noTasks:
      return "noTasks";
    case TasksState.success:
      return "success";
    case TasksState.error:
      return "error";
  }
}

class TasksController extends ChangeNotifier {
  static const _key = "TasksController";
  late TasksState _state;
  late TaskRepo tasksRepo;

  late List<Task>? tasks;

  late String _userToken;
  ControllerResult<TasksException>? _error;

  TasksController({String userToken = ""}) {
    _state = TasksState.initial;
    _userToken = userToken;
    tasksRepo = TaskRepo();
    _changeState(_state);
  }

  TasksState get state => _state;
  ControllerResult<TasksException>? get error => _error;
  String get userToken => _userToken;

  set setUserToken(String userToken) {
    _userToken = userToken;
  }

  void _emit() {
    print("[$_key] _emit invoked");
    notifyListeners();
  }

  void _changeState(TasksState state) {
    print("[$_key] _changeState invoked, " +
        "state changed: ${getMainTaskStateKey(state)}");

    _state = state;

    _emit();
  }

  Future<void> getTaskList() async {
    _changeState(TasksState.loading);

    try {
      var taskResult =
          await tasksRepo.getAllTasksByToken(TaskArgs(token: _userToken));

      if (taskResult.hasData()) {
        tasks = taskResult.data!;
        if (taskResult.data!.isEmpty) {
          _changeState(TasksState.noTasks);
        } else {
          _changeState(TasksState.success);
        }
      }
    } catch (e) {
      print("[$_key] There was an error");
      _changeState(TasksState.error);
    }
  }

  Future<void> postTask(TaskArgs args) async {
    _changeState(TasksState.loading);

    try {
      Result<CreateTaskResponse> taskResult =
          await tasksRepo.postTaskByToken(args);

      if (taskResult.hasData()) {
        tasks = [
          ...tasks!,
          Task(
              id: taskResult.data!.taskEntity!.id,
              title: taskResult.data!.taskEntity!.title,
              isCompleted: taskResult.data!.taskEntity!.isCompleted,
              dueDate: taskResult.data!.taskEntity!.dueDate)
        ];
        _changeState(TasksState.success);
      }
    } catch (e) {
      print("[$_key] There was an error");
      _changeState(TasksState.error);
    }
  }
}

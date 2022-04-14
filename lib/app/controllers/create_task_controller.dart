import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/models/core/controller_result.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/requests/get_task.dart';
import 'package:flutter_task_manager/app/models/responses/create_task.dart';
import 'package:flutter_task_manager/app/models/responses/delete_task.dart';
import 'package:flutter_task_manager/app/models/responses/put_task.dart';
import 'package:flutter_task_manager/app/models/tasks/Task.dart';
import 'package:flutter_task_manager/app/presentation/screens/tasks_screen.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:flutter_task_manager/app/repos/task.dart';

enum TasksException { loadingTasksFailure, undefined }

enum TasksState {
  /// The initial state loads the map for the first time, shows the title and subtitle.
  initial,

  /// The loading state is for the map when is loading, it shows a progrss indicator instead
  loading,

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
    case TasksState.success:
      return "success";
    case TasksState.error:
      return "error";
  }
}

class CreateTaskController extends ChangeNotifier {
  static const _key = "CreateTaskController";
  late TasksState _state;
  late TaskRepo tasksRepo;
  late GlobalKey<FormState> _formKey;

  late String _userToken;
  late String _title;
  late int _isCompleted = 0;
  late String _dueDate;
  late String _comments;
  late String _description;
  late String _tags;

  ControllerResult<TasksException>? _error;

  CreateTaskController({String userToken = ""}) {
    _formKey = GlobalKey<FormState>();
    _state = TasksState.initial;
    _userToken = userToken;
    tasksRepo = TaskRepo();
    _changeState(_state);
  }

  TasksState get state => _state;
  ControllerResult<TasksException>? get error => _error;
  String get userToken => _userToken;
  int get isCompleted => _isCompleted;
  String get dueDate => _dueDate;
  String get comments => _comments;
  String get description => _description;
  String get tags => _tags;
  GlobalKey<FormState> get formKey => _formKey;

  set setUserToken(String userToken) {
    _userToken = userToken;

    _emit();
  }

  set setTitle(String title) {
    _title = title;

    _emit();
  }

  set setIsCompleted(int isCompleted) {
    _isCompleted = isCompleted;

    _emit();
  }

  set setDate(String date) {
    _dueDate = date;

    _emit();
  }

  set setComments(String comments) {
    _comments = comments;

    _emit();
  }

  set setDescription(String description) {
    _description = description;

    _emit();
  }

  set setTags(String tags) {
    _tags = tags;

    _emit();
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

  Future<void> postTask(BuildContext context) async {
    _changeState(TasksState.loading);

    try {
      Result<CreateTaskResponse> taskResult = await tasksRepo.postTaskByToken(
          TaskArgs(
              taskRequest: TaskRequest(_userToken, _title, _isCompleted,
                  dueDate: _dueDate.isEmpty ? null : _dueDate,
                  comments: _comments.isEmpty ? null : _comments,
                  description: _description.isEmpty ? null : _description,
                  tags: _tags.isEmpty ? null : _tags)));

      if (taskResult.hasData()) {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TasksScreen(
                    userName: _userToken,
                  )),
        );
      }
    } catch (e) {
      print("[$_key] There was an error");
      _changeState(TasksState.error);
    }
  }
}

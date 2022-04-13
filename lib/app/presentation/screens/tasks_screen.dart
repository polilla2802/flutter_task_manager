import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/requests/get_task.dart';
import 'package:flutter_task_manager/app/models/responses/create_task.dart';
import 'package:flutter_task_manager/app/models/responses/delete_task.dart';
import 'package:flutter_task_manager/app/models/responses/put_task.dart';
import 'package:flutter_task_manager/app/models/tasks/Task.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:flutter_task_manager/app/repos/task.dart';

class TasksScreen extends StatefulWidget {
  static const String tasks_screen_key = "/tasks_screen";

  TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState(tasks_screen_key);
}

class _TasksScreenState extends State<TasksScreen> {
  String? _key;

  TaskRepo? tasksRepo;
  int? _id;
  String _title = "";
  bool? _isCompleted;
  String? _dueDate;

  _TasksScreenState(String tasks_screen_key) {
    _key = tasks_screen_key;
    tasksRepo = TaskRepo();
  }

  @override
  void initState() {
    super.initState();
    print("$_key invoked");
    WidgetsBinding.instance!
        .addPostFrameCallback((_) async => await _afterBuild());
  }

  Future<void> _afterBuild() async {}

  Future<void> _getTasksByToken({String? token}) async {
    Result<List<Task>> tasks =
        await tasksRepo!.getAllTasksByToken(TaskArgs(token: token));
    setState(() {
      _title = tasks.data![0].title!;
    });
  }

  Future<void> _postTask(TaskRequest task) async {
    Result<CreateTaskResponse> tasks =
        await tasksRepo!.postTaskByToken(TaskArgs(taskRequest: task));
    print("task created ${tasks.data!.detail}");
  }

  Future<void> _getTaskById({int? taskId}) async {
    Result<Task> task = await tasksRepo!.getTaskById(TaskArgs(taskId: taskId));
  }

  Future<void> _putTaskById(TaskRequest task) async {
    Result<PutTaskResponse> tasks =
        await tasksRepo!.putTaskById(TaskArgs(taskRequest: task));
  }

  Future<void> _deleteTaskById(TaskRequest task) async {
    Result<DeleteTaskResponse> tasks =
        await tasksRepo!.deleteTaskById(TaskArgs(taskRequest: task));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_key!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _title,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _postTask(TaskRequest(
            title: "test",
            isCompleted: 0,
            dueDate: "2022-04-12",
            comments: "test",
            description: "test",
            tags: "test",
            token: "Joe123")),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

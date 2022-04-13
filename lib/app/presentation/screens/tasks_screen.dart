import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/controllers/tasks_controller.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/requests/get_task.dart';
import 'package:flutter_task_manager/app/models/responses/create_task.dart';
import 'package:flutter_task_manager/app/models/responses/delete_task.dart';
import 'package:flutter_task_manager/app/models/responses/put_task.dart';
import 'package:flutter_task_manager/app/models/tasks/Task.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:flutter_task_manager/app/repos/task.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  static const String tasks_screen_key = "/tasks_screen";
  final String? userName;

  TasksScreen({Key? key, this.userName}) : super(key: key);

  @override
  State<TasksScreen> createState() =>
      _TasksScreenState(tasks_screen_key, userName);
}

class _TasksScreenState extends State<TasksScreen> {
  String? _key;
  late TaskRepo tasksRepo;
  late TasksController _tasksController;

  _TasksScreenState(String tasks_screen_key, String? userName) {
    _key = tasks_screen_key;
    _tasksController = TasksController(userToken: userName!);
    tasksRepo = TaskRepo();
  }

  @override
  void initState() {
    super.initState();
    print("$_key invoked");
    WidgetsBinding.instance!
        .addPostFrameCallback((_) async => await _afterBuild());
  }

  Future<void> _afterBuild() async {
    await _tasksController.getTaskList();
  }

  Future<void> _postTask({TaskRequest? task}) async {
    await _tasksController.postTask(TaskArgs(taskRequest: task));
  }

  Future<void> _getTaskById({int? taskId}) async {
    Result<Task> task = await tasksRepo.getTaskById(TaskArgs(taskId: taskId));
  }

  Future<void> _putTaskById(TaskRequest task) async {
    Result<PutTaskResponse> tasks =
        await tasksRepo.putTaskById(TaskArgs(taskRequest: task));
  }

  Future<void> _deleteTaskById(TaskRequest task) async {
    Result<DeleteTaskResponse> tasks =
        await tasksRepo.deleteTaskById(TaskArgs(taskRequest: task));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _tasksController,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_tasksController.userToken),
          ),
          body: _buildBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _postTask(
                task: TaskRequest(
                    title: "test",
                    isCompleted: 0,
                    dueDate: "2022-04-12",
                    comments: "test",
                    description: "test",
                    tags: "test",
                    token: _tasksController.userToken)),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ));
  }

  Widget _buildBody() {
    return Consumer<TasksController>(
      builder: (context, _tasksController, child) {
        switch (_tasksController.state) {
          case TasksState.initial:
            return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("holi")],
                ));
          case TasksState.loading:
            return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ));
          case TasksState.success:
            return Container(alignment: Alignment.center, child: _buildTasks());
          case TasksState.noTasks:
            return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("No tasks sorry")],
                ));
          default:
            return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("crayoli")],
                ));
        }
      },
    );
  }

  Widget _buildTasks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _tasksController.tasks!
          .asMap()
          .map((i, item) => MapEntry(
                i,
                _getTask(i, item),
              ))
          .values
          .toList(),
    );
  }

  Widget _getTask(int id, Task task) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(task.id.toString())]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/controllers/tasks_controller.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/requests/get_task.dart';
import 'package:flutter_task_manager/app/models/tasks/Task.dart';
import 'package:flutter_task_manager/app/presentation/components/cards/task_card.dart';
import 'package:flutter_task_manager/app/presentation/screens/create_task_screen.dart';
import 'package:flutter_task_manager/app/presentation/screens/login_screen.dart';
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

  Future<void> _postTask({String? token}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateTaskScreen(
                userName: token,
              )),
    );
  }

  Future<void> _logOut() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<void> _getTaskById({int? taskId}) async {
    Result<Task> task = await tasksRepo.getTaskById(
        TaskArgs(taskId: taskId, token: _tasksController.userToken));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: ChangeNotifierProvider(
            create: (context) => _tasksController,
            child: Scaffold(
                appBar: AppBar(
                  leading: Container(),
                  title: Text(
                    _tasksController.userToken,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    GestureDetector(
                        onTap: () => _logOut(),
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 16),
                            child: Text("Logout")))
                  ],
                ),
                body: _buildBody(),
                floatingActionButton: _floatingButton())));
  }

  Widget _buildBody() {
    return Container(
        padding: EdgeInsets.all(16),
        child: Consumer<TasksController>(
          builder: (context, _tasksController, child) {
            switch (_tasksController.state) {
              case TasksState.initial:
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text("Hola Mundo!")],
                  ),
                );
              case TasksState.loading:
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                );
              case TasksState.success:
                return Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                      child: Wrap(children: [_buildTasks()])),
                );

              case TasksState.noTasks:
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text("No tienes ninguna tarea aún")],
                  ),
                );
              default:
                return Container(child: Text("crayoli"));
            }
          },
        ));
  }

  Widget _buildTasks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
    return TaskCard(
      _tasksController.userToken,
      task: task,
      tasksController: _tasksController,
    );
  }

  Widget _floatingButton() {
    return Consumer<TasksController>(
      builder: (context, _tasksController, child) {
        switch (_tasksController.state) {
          case TasksState.initial:
          case TasksState.loading:
            return Container();
          case TasksState.success:
          case TasksState.noTasks:
          default:
            return FloatingActionButton(
              onPressed: () => _postTask(token: _tasksController.userToken),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
        }
      },
    );
  }
}

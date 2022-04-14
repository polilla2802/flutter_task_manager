import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/controllers/create_task_controller.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/models/requests/get_task.dart';
import 'package:flutter_task_manager/app/models/responses/create_task.dart';
import 'package:flutter_task_manager/app/presentation/components/cards/create_task.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:provider/provider.dart';

class CreateTaskScreen extends StatefulWidget {
  static const String create_task_screen_key = "/create_task_screen";
  final String? userName;

  CreateTaskScreen({Key? key, this.userName}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() =>
      _CreateTaskScreenState(create_task_screen_key, userName);
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  String? _key;
  late CreateTaskController _createTaskController;

  _CreateTaskScreenState(String create_task_screen_key, String? userName) {
    _key = create_task_screen_key;
    _createTaskController = CreateTaskController(userToken: userName!);
  }

  Future<void> _postTask({TaskRequest? task, BuildContext? context}) async {
    if (_createTaskController.formKey.currentState!.validate()) {
      _createTaskController.formKey.currentState!.save();
      await _createTaskController.postTask(context!);
    }
  }

  @override
  void initState() {
    super.initState();
    print("$_key invoked");
    WidgetsBinding.instance!
        .addPostFrameCallback((_) async => await _afterBuild());
  }

  Future<void> _afterBuild() async {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _createTaskController,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text("Create Task"),
            ),
            body: _buildBody(context),
            floatingActionButton: _floatingButton(context)));
  }

  Widget _buildBody(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      Container(
          padding: EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Consumer<CreateTaskController>(
                                      builder:
                                          (context, _tasksController, child) {
                                        switch (_tasksController.state) {
                                          case TasksState.success:
                                          case TasksState.loading:
                                            return Container(
                                              alignment: Alignment.center,
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          case TasksState.error:
                                            return Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    "Lo siento hubo un error"));
                                          case TasksState.initial:
                                          default:
                                            return CreateTaskCard(
                                              createTaskController:
                                                  _createTaskController,
                                            );
                                        }
                                      },
                                    )
                                  ],
                                ),
                              )
                            ])))
              ]))
    ]);
  }

  Widget _floatingButton(BuildContext context) {
    return Consumer<CreateTaskController>(
      builder: (context, _tasksController, child) {
        switch (_tasksController.state) {
          case TasksState.success:
          case TasksState.loading:
            return Container();
          case TasksState.initial:
          default:
            return FloatingActionButton(
              onPressed: () => _postTask(context: context),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/models/core/result.dart';
import 'package:flutter_task_manager/app/repos/task.dart';

class TasksScreen extends StatefulWidget {
  static const String tasks_screen_key = "/tasks_screen";

  TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState(tasks_screen_key);
}

class _TasksScreenState extends State<TasksScreen> {
  TaskRepo? tasksRepo;

  Future<void> _incrementCounter() async {
    Result<String> tasks = await tasksRepo!.getAllTasks("NextlineTest123");
  }

  String? _tasks_screen_key;
  _TasksScreenState(String tasks_screen_key) {
    _tasks_screen_key = tasks_screen_key;
    tasksRepo = TaskRepo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tasks_screen_key!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Holi crayoli',
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

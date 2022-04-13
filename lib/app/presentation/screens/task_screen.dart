import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  static const String task_screen_key = "/task_screen";

  TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState(task_screen_key);
}

class _TaskScreenState extends State<TaskScreen> {
  String? _key;

  _TaskScreenState(String task_screen_key) {
    _key = task_screen_key;
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_key!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Task",
            )
          ],
        ),
      ),
    );
  }
}

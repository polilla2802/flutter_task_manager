import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/controllers/tasks_controller.dart';
import 'package:flutter_task_manager/app/models/requests/get_task.dart';
import 'package:flutter_task_manager/app/models/tasks/Task.dart';
import 'package:flutter_task_manager/app/providers/task.dart';
import 'package:flutter_task_manager/services/utils/colors.dart';

enum TaskOptions { edit, delete }

class TaskCard extends StatefulWidget {
  final String token;
  final Task? task;
  final TasksController? tasksController;

  TaskCard(
    this.token, {
    Key? key,
    this.task,
    this.tasksController,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState(
        token,
        task,
        tasksController,
      );
}

class _TaskCardState extends State<TaskCard> {
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  late TasksController _tasksController;

  late String _token;
  late int _id;
  late String _title = "";
  late int _isCompleted = 0;
  late String? _dueDate = "";

  final EdgeInsetsGeometry buttonMargin =
      const EdgeInsets.only(top: 8, bottom: 8);

  _TaskCardState(
    String token,
    Task? task,
    TasksController? tasksController,
  ) {
    _token = token;
    _id = task!.id;
    _title = task.title;
    _isCompleted = task.isCompleted;
    _dueDate = task.dueDate;
    _tasksController = tasksController!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: buttonMargin,
      child: GestureDetector(
        onTap: () {},
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
                color: _isCompleted == 0 ? Colors.red : Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isCompleted == 0 ? "Pending" : "Completed",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3, right: 3, left: 3),
            decoration: BoxDecoration(
                color: _isCompleted == 0 ? Colors.red : Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: ListTile(
                            leading: Container(
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.task,
                                  color: Colors.white,
                                ),
                                radius: 25,
                                backgroundColor: _isCompleted == 0
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                            dense: true,
                            minVerticalPadding: 5,
                            minLeadingWidth: 10,
                            horizontalTitleGap: 8,
                            title: Container(
                                child: Text(
                              _id.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: _isCompleted == 0
                                      ? Colors.red
                                      : Colors.green),
                            )),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  _title,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: _isCompleted == 0
                                          ? Colors.red
                                          : Colors.green),
                                ),
                                Container(height: 10),
                                _dueDate != null
                                    ? Text(
                                        "Tienes hasta ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Container(),
                                Text(
                                  _dueDate != null
                                      ? _dueDate!
                                      : "Fecha sin definir",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: _isCompleted == 0
                                          ? Colors.red
                                          : Colors.green),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Container(
                      child: PopupMenuButton<TaskOptions>(
                        padding: EdgeInsets.only(right: 0),
                        icon: Icon(Icons.more_vert,
                            size: 40, color: HexColor.fromHex("#DEDEDE")),
                        onSelected: (TaskOptions result) async {
                          if (result == TaskOptions.edit) {
                          } else if (result == TaskOptions.delete) {
                            await _tasksController.deleteTask(
                                TaskArgs(taskId: _id, token: _token));
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<TaskOptions>>[
                          PopupMenuItem<TaskOptions>(
                            value: TaskOptions.edit,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("Edit"),
                            ),
                          ),
                          PopupMenuItem<TaskOptions>(
                            value: TaskOptions.delete,
                            child: Text("Delete"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/controllers/create_task_controller.dart';
import 'package:flutter_task_manager/app/presentation/components/form/input.dart';
import 'package:flutter_task_manager/services/utils/colors.dart';

enum TaskOptions { completed, notCompleted }

class CreateTaskCard extends StatefulWidget {
  final CreateTaskController? createTaskController;

  CreateTaskCard({Key? key, this.createTaskController}) : super(key: key);

  @override
  State<CreateTaskCard> createState() =>
      _CreateTaskCardState(createTaskController);
}

class _CreateTaskCardState extends State<CreateTaskCard> {
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _dateController = TextEditingController();
  late TextEditingController _commentController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _tagController = TextEditingController();

  late CreateTaskController _createTaskController;

  final EdgeInsetsGeometry buttonMargin =
      const EdgeInsets.only(top: 8, bottom: 8);

  _CreateTaskCardState(CreateTaskController? createTaskController) {
    _createTaskController = createTaskController!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: buttonMargin,
      child: GestureDetector(
        onTap: () {},
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: _createTaskController.isCompleted == 0
                    ? Colors.red
                    : Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: CircleAvatar(
                        child: Icon(
                          Icons.task,
                          color: Colors.white,
                        ),
                        radius: 25,
                        backgroundColor: _createTaskController.isCompleted == 0
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                    Text(
                      "Tarea",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: PopupMenuButton<TaskOptions>(
                    padding: EdgeInsets.only(right: 0),
                    icon: Icon(Icons.more_vert, size: 30, color: Colors.white),
                    onSelected: (TaskOptions result) {
                      if (result == TaskOptions.completed) {
                        _createTaskController.setIsCompleted = 1;
                      } else if (result == TaskOptions.notCompleted) {
                        _createTaskController.setIsCompleted = 0;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<TaskOptions>>[
                      PopupMenuItem<TaskOptions>(
                        value: TaskOptions.completed,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("Completada"),
                        ),
                        enabled: _createTaskController.isCompleted == 1
                            ? false
                            : true,
                      ),
                      PopupMenuItem<TaskOptions>(
                        value: TaskOptions.notCompleted,
                        child: Text("Pendiente"),
                        enabled: _createTaskController.isCompleted == 0
                            ? false
                            : true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3, right: 3, left: 3),
            decoration: BoxDecoration(
                color: _createTaskController.isCompleted == 0
                    ? Colors.red
                    : Colors.green,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Form(
                        key: _createTaskController.formKey,
                        child: ListTile(
                          dense: true,
                          minVerticalPadding: 5,
                          minLeadingWidth: 10,
                          horizontalTitleGap: 8,
                          title: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Titulo",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Input(
                                    color:
                                        _createTaskController.isCompleted == 0
                                            ? Colors.red
                                            : Colors.green,
                                    controller: _titleController,
                                    labelText: "Ingresa un titulo",
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor ingresa un Titulo';
                                      }
                                      return null;
                                    },
                                    onSave: (String? value) {
                                      _createTaskController.setTitle =
                                          value!.trim();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Fecha",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Input(
                                        color:
                                            _createTaskController.isCompleted ==
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                        controller: _dateController,
                                        labelText: "YYYY-MM-DD",
                                        validator: (String? value) {
                                          return null;
                                        },
                                        onSave: (String? value) {
                                          _createTaskController.setDate =
                                              value!.trim();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Comentario",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Input(
                                        color:
                                            _createTaskController.isCompleted ==
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                        controller: _commentController,
                                        labelText: "Ingresa un comentario",
                                        validator: (String? value) {
                                          return null;
                                        },
                                        onSave: (String? value) {
                                          _createTaskController.setComments =
                                              value!.trim();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Descripción",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Input(
                                        color:
                                            _createTaskController.isCompleted ==
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                        controller: _descriptionController,
                                        labelText: "Ingresa una descripción",
                                        validator: (String? value) {
                                          return null;
                                        },
                                        onSave: (String? value) {
                                          _createTaskController.setDescription =
                                              value!.trim();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Tag",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Input(
                                        color:
                                            _createTaskController.isCompleted ==
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                        controller: _tagController,
                                        labelText: "#Tag",
                                        validator: (String? value) {
                                          return null;
                                        },
                                        onSave: (String? value) {
                                          _createTaskController.setTags =
                                              value!.trim();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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

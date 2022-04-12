import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/configuration/environment.dart';
import 'package:flutter_task_manager/app/presentation/screens/tasks_screen.dart';

void main() {
  final key = "main prod";
  print("[$key] invoked");

  BuildEnvironment.init(
      apiBaseAddress: "https://ecsdevapi.nextline.mx",
      defaultLanguage: Locale("en", ""),
      env: Environment.production,
      secretKey: "",
      bearer:
          "e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TasksScreen(),
    );
  }
}

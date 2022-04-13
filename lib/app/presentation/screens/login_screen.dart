import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/presentation/components/input.dart';
import 'package:flutter_task_manager/app/presentation/screens/tasks_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String login_screen_key = "/login_screen";

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState(login_screen_key);
}

class _LoginScreenState extends State<LoginScreen> {
  String? _key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _loginController;
  FocusNode? _myFocus;
  String userName = "";

  _LoginScreenState(String login_screen_key) {
    _key = login_screen_key;
    _myFocus = FocusNode();
    _loginController = TextEditingController();
  }

  @override
  void initState() {
    super.initState();
    print("$_key invoked");
    WidgetsBinding.instance!
        .addPostFrameCallback((_) async => await _afterBuild());
  }

  Future<void> _afterBuild() async {}

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TasksScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Form(
                  key: _formKey,
                  child: Input(
                    controller: _loginController,
                    labelText: "Ingresa tu usuario",
                    validator: (String? value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    onSave: (String? value) {
                      userName = value!;
                    },
                    focusNode: _myFocus,
                  ),
                )),
            GestureDetector(
              onTap: () => _login(context),
              child: Container(
                height: 50,
                width: 100,
                child: Text("login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

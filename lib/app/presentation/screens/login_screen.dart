import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app/presentation/components/form/input.dart';
import 'package:flutter_task_manager/app/presentation/screens/tasks_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String login_screen_key = "/login_screen";

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState(login_screen_key);
}

class _LoginScreenState extends State<LoginScreen> {
  String? _key;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _loginController;
  FocusNode? _myFocus;
  String _userName = "";

  _LoginScreenState(String login_screen_key) {
    _key = login_screen_key;
    _myFocus = FocusNode();
    _loginController = TextEditingController();
    _formKey = GlobalKey<FormState>();
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TasksScreen(
                  userName: _userName,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              leading: Container(),
              title: Text("Login"),
            ),
            body: _buildBody()));
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Input(
                  controller: _loginController,
                  labelText: "Ingresa tu usuario",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSave: (String? value) {
                    _userName = value!.trim();
                  },
                  focusNode: _myFocus,
                ),
              )),
          ElevatedButton(
            onPressed: () => _login(context),
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:homework2/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  final TextEditingController _inputUser = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  final TextEditingController _inputRePassword = TextEditingController();
  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          backgroundColor: Colors.purpleAccent,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: 150.0,
                width: 190.0,
                padding: const EdgeInsets.only(top: 60),
                child: const Center(
                    child: Icon(
                  Icons.people,
                  size: 100,
                  color: Colors.purple,
                )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "User Name"),
                  controller: _inputUser,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Passwords"),
                    controller: _inputPassword,
                  )),
              Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Re-Passwords"),
                    controller: _inputRePassword,
                  )),
              ElevatedButton(
                onPressed: () {
                  if (_inputUser.text != "" &&
                      _inputPassword.text != "" &&
                      _inputRePassword.text != "") {
                    checkUser(_inputUser.text, _inputPassword.text,_inputRePassword.text, context);
                  }
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.purpleAccent),
                ),
              )
            ],
          ),
        ));
  }

  void checkUser(user, pass,repass, BuildContext context) {
    if (user != null && pass == repass) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("SUCCESS"),
              content: const Text("Registers Successfully"),
              actions: [
                TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('user', user);
                      prefs.setString('pass', pass);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("User Name and Password incorrect"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            );
          });
    }
  }
}

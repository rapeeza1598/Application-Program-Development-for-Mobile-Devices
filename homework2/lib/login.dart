import 'package:flutter/material.dart';
import 'package:homework2/couter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  final _inputUser = TextEditingController();
  final _inputPassword = TextEditingController();
  Login({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
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
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "User Name"),
                  controller: _inputUser,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Passwords"),
                    controller: _inputPassword,
                  )),
              ElevatedButton(
                onPressed: () {
                  checkUser(_inputUser.text, _inputPassword.text, context);
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.purpleAccent),
                ),
              )
            ],
          ),
        ));
  }

  void checkUser(username, password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (username == prefs.getString('user') &&
        password == prefs.getString('pass')) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Lonin Success"),
              content: Text("Welcome $username"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Counter()
                        ),
                      );
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else {
      // ignore: use_build_context_synchronously
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

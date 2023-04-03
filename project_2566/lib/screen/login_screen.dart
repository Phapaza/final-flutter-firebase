import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_2566/main.dart';
import 'package:project_2566/screen/create_account_screen.dart';
import 'package:project_2566/service/auth_service.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Goodness Work .."),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 750,
              child: Column(
                children: [
                  Image.network(
                    'https://static1.squarespace.com/static/5ecd677a4c483c5e7ce2e559/t/5ecda5640d634c6b2ad94b37/1646661409869/',
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintTe
                        icon: Icon(xt: "Email",
                          Icons.email_outlined,
                          color: Colors.deepOrangeAccent,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock_outline,
                          color: Colors.deepOrangeAccent,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        bool res = await _service.login(
                            email: _emailController.text,
                            password: _passwordController.text);

                        print(res);
                        if (res) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login Success")));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                        title: "Center of good record",
                                      )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Email/Password is Wrong")));
                        }
                      },
                      child: Text("login")),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateAccountScreen()));
                    },
                    child: const Text("No account? create new >>"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

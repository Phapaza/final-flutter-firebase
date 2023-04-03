// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_2566/screen/login_screen.dart';
import 'package:project_2566/screen/new_list_screen.dart';
import 'package:project_2566/screen/edit_list_screen.dart';
import 'package:project_2566/service/auth_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoodNess',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    User? _currentUser = _service.user;
    String displayEmail = "";

    if (_currentUser != null && _currentUser.email != null) {
      displayEmail = _currentUser.email!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(200, 255, 85, 85),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text('Hello '),
                    ),
                    subtitle: Center(child: Text(displayEmail)),
                  ),
                ],
              ),
            ),
            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.logout_outlined),
                          title: Text('Logout'),
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          },
                        ),
                      ],
                    ))))
          ],
        ),
      ),
      ///////////////////////////////////////////////////
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("list").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null)
            return Center(child: const Text("No data list"));
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataDocuments[index]["name"].toString()),
                subtitle: Text(dataDocuments[index]["number"].toString()),
                onTap: () => _editListScreen(
                    dataDocuments[index].id,
                    dataDocuments[index]["number"],
                    dataDocuments[index]["name"],
                    dataDocuments[index]["goodness"]),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewList,
        tooltip: 'Create New List',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewListScreen()));
  }

  _editListScreen(
    String documentid,
    String number,
    String name,
    String goodness,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditListScreen(documentid, number, name, goodness)));
  }
}

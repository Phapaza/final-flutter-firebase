import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_2566/main.dart';
import 'package:project_2566/service/list_service.dart';

class NewListScreen extends StatefulWidget {
  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  final _number = TextEditingController();
  final _name = TextEditingController();
  final _goodness = TextEditingController();

  final ListService _listService = ListService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _number,
              decoration: InputDecoration(label: Text("Number")),
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(label: Text("Name")),
            ),
            TextField(
              controller: _goodness,
              decoration: InputDecoration(label: Text("Goodness")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _addList, child: const Text("Save"))
          ],
        ),
      ),
    );
  }

  _addList() {
    _listService.addLsit2Firebase(_number.text, {
      "number": _number.text,
      "name": _name.text,
      "goodness": _goodness.text
    });
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyHomePage(title: ("Center of good record"))));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_2566/main.dart';
import 'package:project_2566/service/list_service.dart';

class EditListScreen extends StatefulWidget {
  late String documentid;
  final _number = TextEditingController();
  final _name = TextEditingController();
  final _goodness = TextEditingController();

  EditListScreen(
      String documentid, String number, String name, String goodness) {
    documentid = documentid;
    _number.text = number;
    _name.text = name;
    _goodness.text = goodness;
  }

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen> {
  final ListService _listService = ListService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: widget._number,
              decoration: const InputDecoration(label: Text("Number")),
              readOnly: true,
            ),
            TextField(
              controller: widget._name,
              decoration: const InputDecoration(label: Text("Name")),
            ),
            TextField(
              controller: widget._goodness,
              decoration: const InputDecoration(label: Text("Goodness")),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: _deleteList, child: const Text("Delete")),
            ),
            ElevatedButton(onPressed: _editList, child: const Text("Update"))
          ],
        ),
      ),
    );
  }

  void _editList() {
    _listService.editList(widget._number.text, {
      "number": widget._number.text,
      "name": widget._name.text,
      "goodness": widget._goodness.text
    });
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyHomePage(title: ("Center of good record"))));
  }

  void _deleteList() {
    _listService.deleteList(
      widget._number.text,
    );
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyHomePage(title: ("Center of good record"))));
  }
}

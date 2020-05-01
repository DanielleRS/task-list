import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _taskList = [];
  TextEditingController _controllerTask = TextEditingController();

  Future<File>_getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/dados.json");
  }

  _saveTask() {
    String typedText = _controllerTask.text;

    Map<String, dynamic> task = Map();
    task["title"] = typedText;
    task["fulfilled"] = false;

    setState(() {
      _taskList.add(task);
    });
    _saveFile();
    _controllerTask.text = "";
  }

  _saveFile() async {
    var file = await _getFile();

    String data = json.encode(_taskList);
    file.writeAsString(data);
  }

  _readFile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch(e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _readFile().then((data){
      setState(() {
        _taskList = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

   //_saveFile();
    //print("itens: " + _taskList.toString());

    return Scaffold(
      appBar: AppBar(
          title: Text("Lista de tarefas"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Adicionar Tarefa"),
                  content: TextField(
                    controller: _controllerTask,
                    decoration: InputDecoration(
                        labelText: "Digite sua tarefa"
                    ),
                    onChanged: (text){},
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Cancelar"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text("Salvar"),
                      onPressed: (){
                        _saveTask();
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              }
          );
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _taskList.length,
                itemBuilder: (context, index){

                  return CheckboxListTile(
                    title: Text(_taskList[index]['title']),
                    value: _taskList[index]['fulfilled'],
                    onChanged: (changedValue) {
                      setState(() {
                        _taskList[index]['fulfilled'] = changedValue;
                      });
                      _saveFile();
                    },
                  );
                  /*return ListTile(
                    title: Text(_taskList[index]['title']),
                  );*/
                }
            ),
          )
        ],
      ),
    );
  }
}

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

  _saveFile() async {
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/dados.json");

    //Criar dados
    Map<String, dynamic> task = Map();
    task["title"] = "Ir ao mercado";
    task["fulfilled"] = false;
    _taskList.add(task);

    String data = json.encode(_taskList);
    file.writeAsString(data);
  }

  @override
  Widget build(BuildContext context) {

    _saveFile();

    return Scaffold(
      appBar: AppBar(
          title: Text("Lista de tarefas"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _taskList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_taskList[index]),
                  );
                }
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          onPressed: (){
            showDialog(
                context: context,
              builder: (context) {
                  return AlertDialog(
                    title: Text("Adicionar Tarefa"),
                    content: TextField(
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
                          //save
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
              }
            );
          },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _taskList = ["Ir ao mercado", "Estudar", "Exercício do dia"];

  @override
  Widget build(BuildContext context) {
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

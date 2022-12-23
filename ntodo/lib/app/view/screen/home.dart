
import 'package:flutter/material.dart';
import 'package:ntodo/utils/db.dart';

import '../../model/todo.dart';
import '../widget/tarefa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController todo = TextEditingController();
  List<Todo> todoLista = [];
  DbHelper db = DbHelper();

  void add() {
    Todo td = Todo(title: todo.text, status: false);
    db.insert(td).then((tarefas) {
      db.getAll().then((value) {
        setState(() {
          todo.text = '';
          todoLista = value as List<Todo>;
      
        });
      });
    });
  }

  void getAll() {
  
    db.getAll().then((value) {
      setState(() {
        todoLista = value as List<Todo>;
      });
    });
  }

  void delete([Todo? todo]) {
   
    db.delete(todo!.id!).then((value) {
      getAll();
      Todo aux = todo;
      ScaffoldMessenger.of(context).clearSnackBars();// limpa a snackbar antiga caso aparece uma nova
      ScaffoldMessenger.of(context).showSnackBar(// chama a snackbar
      SnackBar(
        duration: const Duration(seconds: 6),// para saber o tempo de duração que fica aparecendo
        content: Text('tarefa ${aux.title} foi removida!'),
        action: SnackBarAction(// botão
            label: 'Desfazer',
            onPressed: () {
              db.insert(aux).then((value) {
                getAll();
              });
            }),
      ));
    });
  }



Future refresh() async{
  await Future.delayed(const Duration(seconds: 1));//vai esparar 1 segundo antes de iniciar
  getAll();
}

  @override
  void initState() {
    super.initState();
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: TextField(
                    controller: todo,
                    decoration:const InputDecoration(label:  Text('Nova Tarefa')),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                      onPressed: () {
                        add();
                      },
                      child:const  Text('ADD')),
                )
              ],
            ),
            Expanded(
                child: RefreshIndicator(child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: todoLista.length,
              itemBuilder: (BuildContext context, int index) {
                return Tarefa(
                  todo: todoLista[index],
                  fun: () {
                    delete(todoLista[index]);
                    //getAll();
                  }, // envia dentro de uma função anonima
                );
              },
            ), onRefresh: refresh// não usa o parenteses, quero a instacia e não o valor dela.

            ,))
          ],
        ),
      ),
    );
  }
}

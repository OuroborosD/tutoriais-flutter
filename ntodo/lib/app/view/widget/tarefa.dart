import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ntodo/app/model/todo.dart';
import 'package:ntodo/utils/db.dart';



class Tarefa extends StatefulWidget {
  const Tarefa({super.key, this.todo, this.fun});
  final Todo? todo;
  final VoidCallback? fun;

  @override
  State<Tarefa> createState() => _TarefaState();
}

class _TarefaState extends State<Tarefa> {
  bool check = false;
  DbHelper db = DbHelper();
  void change() {
    widget.todo!.status = !widget.todo!.status!;
    db.update(widget.todo!);
    setState(() {
      widget.todo!.status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: CheckboxListTile(
        value: widget.todo!.status,
        onChanged: (value) {
          change();
          
        },
        secondary: Icon(
          widget.todo!.status == false
              ? Icons.error
              : Icons.check_circle, // muda de acordo com o status
          color: Colors.blueAccent,
          size: 40,
        ),
        title: Text(widget.todo!.title.toString()),
        // trailing: Icon(
        //   Icons.check_box,
        //   color: Colors.blueAccent,
        //   size: 25,
        // ),
      ),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
         children: [
          SlidableAction(
            onPressed: (context){
              //Todo aux =  widget.todo!;
              //db.delete(widget.todo!.id!).then((value){
              widget.fun!();
              // final snack =SnackBar(content: Text('tarefa ${aux.title} foi removida!'),
              // action: SnackBarAction(label: 'Desfazer', onPressed: (){
              //   db.insert(aux).then((value){
              //     widget.fun!();
              //   });
              // }),
              // );
              
              //});
          },
          
          backgroundColor:  Colors.red,
          foregroundColor: Colors.white,
          icon:Icons.delete,
          label: 'Deletar',
          )
      ]),
    );
  }
}

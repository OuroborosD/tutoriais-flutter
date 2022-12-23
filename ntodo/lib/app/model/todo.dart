class Todo{
  Todo({this.status,this.title, this.id});
  int? id;
  String? title;
  bool? status;

  
  Todo.fromMap(Map map){// transformar o mapa em dados da classe
    id = map['id'];// vai pegar a row com os dados tranformar em mapa, e o map['colunma'] vai ser colocado aqui
    status = map['status'] == 0 ? false: true;
    title = map['title'];
   
  } 
  
  Map<String, dynamic> toMap(){// transforma o objeto em mapa
   Map<String, dynamic> map = {// não tem id, pois é o banco de dados que vai gerar
    'status': status == false ? 0 : 1, 
    'title': title,
   };
   if( id != null){// cria uma chave chamada id, e coloca o id no va-lue
    map['id'] = id;
   }
   return map;

  }

  @override
 String toString(){// override, para mostrar otodos os dados de forma fácil
  return 'id: $id ,tarefa: $title ,status: $status';
 }

}


import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  TextEditingController search = TextEditingController();
  List url = List.generate(20, (index)=> "https://media4.giphy.com/media/3o6ZsX6hzFViYnKwFi/200.gif?cid=dbb35b9e7fr42y1h0ldikgq27r321v9p8qmfc37b4vv49utj&rid=200.gif&ct=g").toList();// gera 20 registros na lista
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding:
                   const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: TextField(
                controller: search,
                style: const TextStyle(color: Colors.white),        
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.white,),
                    label: Text("Pesquise Aqui!",style: TextStyle(color: Colors.white),),
                    border: OutlineInputBorder(), // tipo da borda, que envolve toda a caixa
                    enabledBorder: OutlineInputBorder( // troca a cor da borda
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder( // troca a cor da borda quando clica nela
                        borderSide: BorderSide(color: Colors.white,width: 4)),
                  ),
                onSubmitted: (value){
                  
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                    gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 360, //largura do item
                        mainAxisExtent: 200, // altura do item
                        //childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: url.length, // tamanho da lista
                    itemBuilder: (context, index) {
                      //construtor
                      return Container(
                        //height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.white
                          )
                        ),
                        child: Image.network(url[index]));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

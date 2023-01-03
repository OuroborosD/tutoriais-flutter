import 'package:flutter/material.dart';
import 'package:giphy/app/view/widgets/grid.dart';

import '../../controller/http_controller.dart';

class Gif_homePage extends StatefulWidget {
  const Gif_homePage({super.key});

  @override
  State<Gif_homePage> createState() => _Gif_homePageState();
}

class _Gif_homePageState extends State<Gif_homePage> {
  GifController gif = GifController();
  TextEditingController search = TextEditingController();

  // void get() async {
  //   //pega os dados da api, já tratados e manda para uma lista
  //   List<String> string = await gif.get_Gif() as List<String>;
  //   print(string);
  // }

  void refresh()async{
      gif.offset += 19;
      // chama a função como ela é assincrona, tem que usar o await. 
      //para só depois de terminar de carregar, passar para o setstate
      await gif.get_Gif();
      setState(() {
        widget.createState();
      });
  }

  @override
  void initState() {
    super.initState();
    //get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:10.0),
              child: TextField(
                  controller: search,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Pesquise Aqui!",
                      style: TextStyle(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 4)),
                  ),
                  onSubmitted: (search){
                    setState(() {
                    gif.search = search;
                      widget.createState();
                    });
                    
                  },
                  ),
            ),
            FutureBuilder<List<String>>(
              // o tipo, é do tipo de retorno da função que tem como parame-tro
              future: gif.get_Gif(), // get_finance return a Map, então future-Builder é um map
              builder: (context, snapshot) {
                // snapshot, é uma copia da tela
                switch (snapshot.connectionState) {
                  // verifica se está fluindo o codico, ou ele está parado aguardando a função async
                  case ConnectionState.none: // verifica se não tem nada
                  case ConnectionState
                      .waiting: // verifica se está esperando uma função async
                    return Center(
                      // case esteja esperando entre nessa parte, e carrega o icone de carretgando
                      child: Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),// modifica a cor para branco
                          strokeWidth: 5, // grossura da abertura
                        ),
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      // case de algum erro ao carregar a
                      return const  Center(
                        child: Icon(Icons.error),
                      );
                    } else {
                      //print(snapshot.data);
                      //return  _createGrid(context,snapshot,);
                      return Grid(gifs: snapshot.data, fun: (){ refresh();},);
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


// Widget _createGrid(BuildContext context, AsyncSnapshot snapshot){
//   return Expanded(
//       child: GridView.builder(
//         gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(// um tipo de grid, com o tamanho fixo
//         //por isso da para colocar 
//         crossAxisCount: 2, // ou seja vai ter dois itens na em cada linha
//         crossAxisSpacing: 10,// espaçamento no meio do widget 
//         mainAxisSpacing: 10,
//         ) ,
//         itemCount: snapshot.data.length, 
//         itemBuilder: (context, index){
//           return Image.network(snapshot.data[index], height: 200,fit:BoxFit.cover );
//         }),
//     );
// }
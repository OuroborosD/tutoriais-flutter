import 'package:flutter/material.dart';


import 'package:giphy/app/controller/share_controller.dart';
import 'package:giphy/app/view/screens/gif.dart';
import 'package:transparent_image/transparent_image.dart';

class Grid extends StatelessWidget {
  Grid({super.key, this.gifs, this.fun});
  List<Map>? gifs;
  final VoidCallback? fun;

  bool is_search = false;

  int search(int tamanho) {
    is_search = true;
    return tamanho + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // um tipo de grid, com o tamanho fixo
            //por isso da para colocar
            crossAxisCount: 2, // ou seja vai ter dois itens na em cada linha
            crossAxisSpacing: 10, // espaçamento no meio do widget
            mainAxisSpacing: 10,
          ),

          //EXPLANATION: explicação de como colocar o botão mais no ultimo item
          // verificando  o tamanho da lista, quando retorna par, quer dizer que veio completa e não é para pesquisar,
          //impar é pesquisar, e é  para sobrar espaço para o widget de carregar mais        ===
          itemCount: gifs!.length % 2 == 0
              ? gifs!.length
              : search(gifs!.length), //   <=====||
          itemBuilder: (context, index) {
            if (is_search == false || index < gifs!.length) {
              //print("$index  tamanho total ${gifs!.length}");
           
              return GestureDetector(
                onLongPress: () {
                  share(gifs![index]);
                },
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Gif(url: gifs![index]),
                      ));
                },
                //EXPLANATION :  Resolvendo Erro de String vindo como tuplas ()
                //quando você pega o valoor pelo metodo values. a string vem com parenteses, oque da erro na ora de puxar a imagem
                //oque faz com que tenhamos que tranformar uma uma lista, que modifica os parenteses() por colchetes [], ai é só colocar o index
                child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: gifs![index].values.toList()[0],
                    height: 200,
                    fit: BoxFit.cover),
              );
            } else {
              //print("se entou aqui é para aparecer o botão mais");
              return GestureDetector(
                onTap: () {
                  fun!();
                },
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                     Icon(
                       Icons.add,
                      size: 80,
                      color: Colors.white,
                    ),
                     Text(
                      "adicionar mais",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

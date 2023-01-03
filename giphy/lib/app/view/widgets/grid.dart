import 'package:flutter/material.dart';
import 'package:giphy/app/controller/http_controller.dart';

class Grid extends StatelessWidget {
  Grid({super.key, this.gifs, this.fun});
  List<String>? gifs;
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // um tipo de grid, com o tamanho fixo
            //por isso da para colocar
            crossAxisCount: 2, // ou seja vai ter dois itens na em cada linha
            crossAxisSpacing: 10, // espaçamento no meio do widget
            mainAxisSpacing: 10,
          ),

          //EXPLANATION: explicação de como colocar o botão mais no ultimo item
          // verifica o tamanho da lista, par é que não é pesquisa,
          //impar é pesquisa e é para sobrar espaço para o widget de carregar mais        ===
          itemCount: gifs!.length % 2 == 0? gifs!.length : search(gifs!.length), //   <=====||
          itemBuilder: (context, index) {
            if (is_search == false || index < gifs!.length) {
              print("$index  tamanho total ${gifs!.length}");
              return Image.network(gifs![index],
                  height: 200, fit: BoxFit.cover);
            } else {
              print("se entou aqui é para aparecer o botão mais");
              return GestureDetector(
                onTap: () {
                  fun!();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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

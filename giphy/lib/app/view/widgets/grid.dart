import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  Grid({super.key, this.gifs});
  List<String>? gifs;
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
          itemCount: gifs!.length,
          itemBuilder: (context, index) {
            return Image.network(gifs![index], height: 200, fit: BoxFit.cover);
          }),
    );
  }
}

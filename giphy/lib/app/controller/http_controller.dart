import 'dart:convert';
import 'package:http/http.dart' as http;

class GifController {
  GifController([this.offset = 0, this.search]);
  String? search;
  int offset;

  Map<String, dynamic>? body;
  List<String> lista_imagens = [];

  Future<List<String>> get_Gif([int? offset, String? search]) async {
    Uri? request;
    lista_imagens = []; // lembrar de apagar a lista, para só mostrar oque pesqisou e não ficar com resultados antigos
    print(' é para ter apagado o tamanho da lista ${lista_imagens.length}');
    if (this.search == null || this.search!.isEmpty) {
      request = Uri.parse(
          'https://api.giphy.com/v1/gifs/trending?api_key=xX2ZYCWebdiWuESJQQ6wOjB5JxkSZrLG&limit=20&rating=r');
    } else {

      request = Uri.parse(
          "https://api.giphy.com/v1/gifs/search?api_key=xX2ZYCWebdiWuESJQQ6wOjB5JxkSZrLG&q=${this.search}&limit=19&offset=${this.offset}&rating=r&lang=en");
    }

    http.Response response = await http.get(request);
    body = json.decode(response.body);
    for (Map m in body!['data']) {
      lista_imagens.add(m['images']["fixed_height"]['url']);
    }

    return lista_imagens;
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Network(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      print('Encontrou Manga');
      return jsonDecode(data);
    } else {
      print('Erro ao tentar encontrar Manga');
      print(response.statusCode);
      return -1;
    }
  }
}

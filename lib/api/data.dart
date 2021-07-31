import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class Character {
  List<Article> articles = [];
  Future<void> getChracterDetails() async {
    String url = "https://futuramaapi.herokuapp.com/api/v2/characters";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonData);
    }
  }
}

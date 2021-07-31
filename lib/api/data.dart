import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class Character {
  List<Article> articles = [];
  Future<void> getChracterDetails() async {
    final String url = "https://futuramaapi.herokuapp.com/api/v2/characters";
    var response = await http.get(Uri.parse(url));
    List jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData.length; i++) {
        Article article = Article();
        article.species = jsonData[i]["Species"];
        article.age = jsonData[i]["Age"];
        article.planet = jsonData[i]["Planet"];
        article.profession = jsonData[i]["Profession"];
        article.status = jsonData[i]["Status"];
        article.firstApperance = jsonData[i]["FirstApperance"];
        article.urlToImage = jsonData[i]["PicUrl"];
        article.relatives = jsonData[i]["Relatives"];
        article.voicedBy = jsonData[i]["VoicedBy"];
        article.name = jsonData[i]["Name"];
        articles.add(article);
      }
    }
  }
}

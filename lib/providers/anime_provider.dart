import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/anime_popular_response.dart';
import 'package:peliculas/models/models.dart';

class AnimeProvider extends ChangeNotifier{
  List<Anime> animesPopulares = [];
  AnimeProvider(){
    getPopularAnimes();
  }
  getPopularAnimes() async{
  var url = Uri.https('api.jikan.moe', 'v3/top/anime/1/bypopularity');
  var response = await http.get(url);
  final popularAnimes = PopularAnime.fromJson(response.body);

  animesPopulares = popularAnimes.top;
}
}


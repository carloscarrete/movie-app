import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/search_response.dart';

class MoviesProvider extends ChangeNotifier{
  
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];

  Map<int,List<Cast>> moviesCast = {};
  int _popularPage = 0;
  int _topRatedPage = 0;

  String _apiKey = '7fca11b4d7d080153c7cccba02a68ed1';
  String _language = 'es-ES';
  String _base = 'api.themoviedb.org';

  final StreamController<List<Movie>> _streamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestStream => _streamController.stream;
  
  final debouncer = new Debouncer(duration: Duration(microseconds: 500),);

  MoviesProvider(){
    print('Inicializado');
    getOnDisplayMovies();
    getPopularMovies();
    getTopRatedMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page=1]) async{
    final url = Uri.https(_base, endpoint,{
      'api_key' : _apiKey,
      'language' : _language,
      'page' : '$page'
    });
    final respone = await http.get(url);
    return respone.body;
  }

  getOnDisplayMovies() async{
      final jsonData = await _getJsonData('3/movie/now_playing');
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
  }

  getPopularMovies() async{
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [... popularMovies,... popularResponse.results];
    notifyListeners();
  }

  getTopRatedMovies() async{
    _topRatedPage++;
    final jsonData = await _getJsonData('3/movie/top_rated',_topRatedPage);
    final topRatedMovie = TopRatedResponse.fromJson(jsonData);
    topRatedMovies = [...topRatedMovies,...topRatedMovie.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async{
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast; 
  }

  Future<List<Movie>> searchMovies(String query) async{
    print('valor: $query');
      final url = Uri.https(_base, '3/search/movie',{
      'api_key' : _apiKey,
      'language' : _language,
      'query' : '$query'
    });
    print('valor 2: $query');
    final response = await http.get(url);
    final searchRespone = SearchResponse.fromJson(response.body);
    return searchRespone.results;
  }

  void getSuggestionByQuery(String query){
    debouncer.value = query;
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);
      _streamController.add(results);
    };

    final timer = new Timer.periodic(Duration(milliseconds: 300), (_) { debouncer.value=query;});
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
} 
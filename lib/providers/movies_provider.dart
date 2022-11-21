

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/actors_response.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl  = "api.themoviedb.org";
  final String _apiKey   = "0edc6e0e792e8977e5cd5fef38b81c9a";
  final String _lenguaje = "en-ES";
  List<Movies> moviesProvider = [];
  List<Movies> popularMovies = [];
  Map<int, List<Cast>> movieActors= {};
  int pagePopular = 0;

  MoviesProvider(){
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    final url = Uri.https( _baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _lenguaje,
      'page': '$page'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }


  getNowPlayingMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {
          'page' : '1',
          'api_key' : _apiKey,
          'language' : _lenguaje,

        }
    );
    final response = await http.get(url);
    final jsonResponse = NowPlayingRespnse.fromJson(response.body);

    moviesProvider = jsonResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    pagePopular ++;
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {
          'page' : '$pagePopular',
          'api_key' : _apiKey,
          'language' : _lenguaje,

        }
    );
    final response = await http.get(url);
    final jsonResponse = PopularMoviesResponse.fromJson(response.body);

    popularMovies = [...popularMovies, ...jsonResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieActors( int movieId ) async {

    if( movieActors.containsKey(movieId) ) return movieActors[movieId]!;

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = ActorsResponse.fromJson( jsonData );

    movieActors[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
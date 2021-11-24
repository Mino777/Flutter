import 'dart:convert';
import 'package:flutter_provider/src/model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  Future<List<Movie>?> loadMovies() async {
    var queryParam = {
      'api_key': '6be3f759f3e1e6789572ee80be887691'
    };

    var url = Uri.https('api.themoviedb.org', '/3/movie/popular', queryParam);
    var response = await http.get(url);

    if (response.body != null) {
      Map<String, dynamic> body = json.decode(response.body);

      if (body['results'] != null) {
        List<dynamic> list = body['results'];
        return list.map<Movie>((item) => Movie.fromJson(item)).toList();
      }
    }
  }
}
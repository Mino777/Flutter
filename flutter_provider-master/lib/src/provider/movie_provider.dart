import 'package:flutter/material.dart';
import 'package:flutter_provider/src/model/movie_model.dart';
import 'package:flutter_provider/src/repository/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  MovieRepository _movieRepository = MovieRepository();
  late List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  loadMovies() async {
    List<Movie>? listMovies = await _movieRepository.loadMovies();
    _movies = listMovies!;
    notifyListeners();
  }
}
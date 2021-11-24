class Movie {
  String overview;
  String posterPath;
  String title;

  Movie({required this.overview, required this.posterPath, required this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        overview: json["overview"] as String,
        posterPath: json["poster_path"] as String,
        title: json["title"] as String
    );
  }
  String get posterUrl => 'http://image.tmdb.org/t/p/w500/${this.posterPath}';
}
import 'package:flutter/material.dart';
import 'package:flutter_provider/src/model/movie_model.dart';
import 'package:flutter_provider/src/provider/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieListWidget extends StatelessWidget {
  MovieListWidget({Key? key}) : super(key: key);
  late MovieProvider _movieProvider;

  @override
  Widget build(BuildContext context) {
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    _movieProvider.loadMovies();

    return Scaffold(
        appBar: AppBar(
          title: Text('Movie Provider'),
        ),
        body: Consumer<MovieProvider>(
          builder: (context, provider, widget) {
            if (provider.movies != null && provider.movies.length > 0) {
              return makeListView(provider.movies);
            }

            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget makeListView(List<Movie> movies) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 200,
            child: makeMovieOne(movies[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: movies.length);
  }

  Widget makeMovieOne(Movie movie) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Container(
                child: Image.network(
                  movie.posterUrl,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      child: Text(
                        movie.overview,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13),
                        maxLines: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

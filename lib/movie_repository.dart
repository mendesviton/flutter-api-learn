import 'package:dio/dio.dart';
import 'package:more_api_examples/movie_model.dart';

class MovieRepository {
  final Dio dio;

  MovieRepository(
    this.dio,
  );

  List<MovieModel> movies = [];

  Future<List<MovieModel>> getAllMovies() async {
    final response = await dio.get('https://ghibliapi.herokuapp.com/films');

    movies = List.from(response.data.map((movie) {
      return MovieModel.fromMap(movie);
    }));

    print(movies[0].originalTitle);

    return movies;
  }
}

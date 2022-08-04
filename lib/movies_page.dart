import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:more_api_examples/movie_model.dart';
import 'package:more_api_examples/movie_repository.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  MovieRepository repository = MovieRepository(Dio());
  late Future<List<MovieModel>> movies;

  @override
  void initState() {
    movies = repository.getAllMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          movies.then((value) => print(value[0].id));
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            FutureBuilder(
              future: movies,
              builder: (context, AsyncSnapshot<List<MovieModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 500,
                          width: 500,
                          child: ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                MovieModel myMovie = snapshot.data![index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        decoration:
                                            BoxDecoration(color: Colors.amber),
                                        padding: EdgeInsets.all(8),
                                        child: Center(
                                            child: Text(
                                          myMovie.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ))),
                                    Image.network(myMovie.image,
                                        scale: 3, fit: BoxFit.fill),
                                  ],
                                );
                              }),
                        ),
                      );
                    }
                  case ConnectionState.waiting:
                    {
                      return const CircularProgressIndicator();
                    }

                  default:
                    {
                      return const CircularProgressIndicator();
                    }
                }
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(''),
      ),
    );
  }
}

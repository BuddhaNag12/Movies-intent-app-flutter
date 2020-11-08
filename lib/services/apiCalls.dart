import 'package:movies_intent/constants/movie_const.dart';

import 'package:movies_intent/models/movieModel.dart' as MovieModel;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:movies_intent/constants/apiKey.dart';

Future<Iterable<MovieModel.Result>> fetchData() async {
  var responses = await Future.wait([
    http.get(MovieConstants().movieUrl),
    http.get(MovieConstants().upComingurl),
  ]);
  return [
    ...getMoviesFromResponse(responses.first),
    ...getMoviesFromResponse(responses[1]),
  ];
}

List<MovieModel.Result> getMoviesFromResponse(http.Response response) {
  return [
    if (response.statusCode == 200)
      for (var i in json.decode(response.body)['results'])
        MovieModel.Result.fromJson(i),
  ];
}

Future<MovieModel.Welcome> getMovieswithType(String type, int page) async {
  final String moviesWithType =
      'https://api.themoviedb.org/3/movie/$type?api_key=${ApiKey().apiKey}&language=en-US&page=$page';
  final response = await http.get(moviesWithType);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return MovieModel.Welcome.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

Future<MovieModel.Welcome> searchMovies(
    String movieQuery, int pageNumber) async {
  final String searchQueryUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=${ApiKey().apiKey}&query=$movieQuery&language=en-US&page=$pageNumber';
  final response = await http.get(searchQueryUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return MovieModel.Welcome.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

Future<MovieModel.Welcome> genreSeach(String type, int pageNumber) async {
  final String genresUrl =
      'https://api.themoviedb.org/3/discover/movie?api_key=${ApiKey().apiKey}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&with_genres=$type&page=$pageNumber';
  final response = await http.get(genresUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return MovieModel.Welcome.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

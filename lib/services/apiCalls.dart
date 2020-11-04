import 'package:movies_intent/constants/movie_const.dart';
import 'package:movies_intent/models/movieModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:movies_intent/constants/apiKey.dart';

Future<Welcome> fetchMovies() async {
  final response = await http.get(MovieConstants().movieUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Welcome.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

Future<Welcome> fetchUpcomingMovies() async {
  final response = await http.get(MovieConstants().upComingurl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Welcome.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

Future<Welcome> getMovieswithType(String type) async {
  final String moviesWithType =
      'https://api.themoviedb.org/3/movie/$type?api_key=${ApiKey().apiKey}&language=en-US&page=1';
  final response = await http.get(moviesWithType);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Welcome.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

import 'package:http/http.dart' as http;
import 'package:movies_intent/constants/apiKey.dart';
import 'dart:convert';
import 'dart:async';
import 'package:movies_intent/models/movieDetailModel.dart';

Future<MovieDetailModel> fetchMovieDetail(int id) async {
  String movieDetail =
      'https://api.themoviedb.org/3/movie/$id?api_key=${ApiKey().apiKey}&language=en-US';

  final response = await http.get(movieDetail);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return MovieDetailModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

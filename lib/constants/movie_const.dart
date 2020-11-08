import 'package:movies_intent/constants/apiKey.dart';

class MovieConstants {
  final String movieUrl =
      'https://api.themoviedb.org/3/discover/movie?api_key=${ApiKey().apiKey}&sort_by=popularity.desc&page=1';

  final String upComingurl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${ApiKey().apiKey}&language=en-US&page=1';
  final String popularUrl =
      'https://api.themoviedb.org/3/discover/movie?api_key=${ApiKey().apiKey}&sort_by=popularity.desc&page=1';

  final String roughImage =
      'https://scontent.fgau2-1.fna.fbcdn.net/v/t1.0-9/91433061_3102677403099489_2558380673832321024_n.png?_nc_cat=103&ccb=2&_nc_sid=09cbfe&_nc_ohc=ZHh2Fc8yq_cAX-7NoRW&_nc_ht=scontent.fgau2-1.fna&oh=8f01b3cdeda65facb3b21e6a6e61e71e&oe=5FC28602';

  getImagePath(String path) => 'https://image.tmdb.org/t/p/w780/' + path;

  getBackdropPath(String path) => 'https://image.tmdb.org/t/p/w1280/' + path;

  final backdropImages =
      'https://api.themoviedb.org/3/movie/id/images?api_key=${ApiKey().apiKey}';
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:movies_intent/constants/movie_const.dart';
import 'package:movies_intent/models/movieModel.dart' as movieModel;
import 'package:movies_intent/screens/detailScreen.dart';
import 'package:movies_intent/screens/imageScreen.dart';
import 'package:movies_intent/services/apiCalls.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<movieModel.Welcome> _movies;
  List<movieModel.Result> _searchQuery;
  bool _isLoading = false;

  List<Map<String, dynamic>> genres = [
    {
      'id': 12,
      'name': 'Adventure',
    },
    {'id': 14, 'name': 'Fantasy'},
    {'id': 16, 'name': 'Animation'},
    {'id': 18, 'name': 'Drama'},
    {'id': 27, 'name': 'Horror'},
    {'id': 28, 'name': 'Action'},
    {'id': 35, 'name': 'Comedy'},
    {'id': 36, 'name': 'History'},
    {'id': 37, 'name': 'Western'},
    {'id': 53, 'name': 'Thriller'},
    {'id': 80, 'name': 'Crime'},
    {'id': 99, 'name': 'Documentary'},
    {'id': 878, 'name': 'Science Fiction'},
    {'id': 9648, 'name': 'Mystery'},
    {'id': 10402, 'name': 'Music'},
    {'id': 10749, 'name': 'Romance'},
    {'id': 10751, 'name': 'Family'},
    {'id': 10752, 'name': 'War'},
    {'id': 10770, 'name': 'TV Movie'},
  ];

  // ScrollController _controller;
  int pageNumber = 1;
  final _searchController = TextEditingController();

  // @override
  // void initState() {
  //   // _controller = ScrollController();
  //   // _controller.addListener(_scrollListener);
  //   super.initState();
  // }

  fetchMovies() {
    setState(() {
      _isLoading = true;
    });
    _movies = searchMovies(_searchController.text, pageNumber);
    _movies
        .then((value) => {
              setState(() {
                _isLoading = false;
                _searchQuery = value.results;
              })
            })
        .catchError((E) => {
              print(E),
            });
  }

  searchByGenres(String type) {
    setState(() {
      _isLoading = true;
    });
    _movies = genreSeach(type, pageNumber);
    _movies
        .then((value) => {
              setState(() {
                _isLoading = false;
                _searchQuery = value.results;
              })
            })
        .catchError((E) => {
              print(E),
            });
  }

  // _scrollListener() {
  //   if (_controller.offset >= _controller.position.maxScrollExtent &&
  //       !_controller.position.outOfRange) {
  //     print("calling");
  //     this.pageNumber++;
  //     _movies = searchMovies(_searchController.text, pageNumber);
  //     _movies.then((value) => {
  //           setState(() {
  //             _searchQuery.addAll(value.results);
  //           })
  //         });
  //   }
  // }

  // @override
  // void dispose() {
  //   _searchController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          // controller: _controller,
          child: Container(
              child: Column(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.black54.withOpacity(0.3),
                      //       blurRadius: 4,
                      //       spreadRadius: 0,
                      //       offset: Offset(0, 2)),
                      // ]),
                    ),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (text) => fetchMovies(),
                      onSubmitted: (text) => fetchMovies(),
                      cursorRadius: Radius.circular(24),
                      // autofocus: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito-Light',
                            fontWeight: FontWeight.bold),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Search For Movies',
                        prefixIcon: Icon(Icons.search),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    child: Text(
                      'Genres',
                      style: TextStyle(fontFamily: 'Nunito-Bold', fontSize: 25),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ListView.builder(
                      itemCount: genres.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: index % 2 == 0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent),
                            child: FlatButton(
                                padding: EdgeInsets.all(5),
                                onPressed: () => searchByGenres(
                                    genres[index]['id'].toString()),
                                child: Text(
                                  genres[index]['name'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito-Bold'),
                                )));
                      },
                    ),
                  ),
                  _isLoading
                      ? Center(
                          child: Loading(
                              indicator: BallPulseIndicator(),
                              size: 50.0,
                              color: Colors.amber),
                        )
                      : _searchQuery != null
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                itemCount: _searchQuery.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      dense: true,
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        movieId:
                                                            _searchQuery[index]
                                                                .id)),
                                          ),
                                      leading: _searchQuery[index].posterPath !=
                                              null
                                          ? Hero(
                                              tag: _searchQuery[index]
                                                  .posterPath,
                                              child: posterWidget(context,
                                                  imagePath: _searchQuery[index]
                                                      .posterPath,
                                                  roughimage: false),
                                            )
                                          : _searchQuery[index].backdropPath !=
                                                  null
                                              ? Hero(
                                                  tag: _searchQuery[index]
                                                      .backdropPath,
                                                  child: posterWidget(
                                                    context,
                                                    imagePath:
                                                        _searchQuery[index]
                                                            .backdropPath,
                                                    roughimage: false,
                                                  ),
                                                )
                                              : posterWidget(context,
                                                  roughimage: true),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      subtitle:
                                          _searchQuery[index].releaseDate !=
                                                  null
                                              ? Text(DateFormat('yyyy-MM-dd')
                                                  .format(_searchQuery[index]
                                                      .releaseDate))
                                              : Text('No Date found'),
                                      title: Text(_searchQuery[index].title),
                                      trailing: Text(
                                          '${_searchQuery[index].voteAverage.toString()} / 10'));
                                },
                              ),
                            )
                          : SizedBox()
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}

Widget posterWidget(BuildContext context, {String imagePath, bool roughimage}) {
  return !roughimage
      ? GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageScreen(
                        imagePath: imagePath,
                      ))),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.memoryNetwork(
                placeholderCacheHeight: 20,
                placeholderCacheWidth: 20,
                fadeInCurve: Curves.easeIn,
                placeholder: kTransparentImage,
                image: MovieConstants().getBackdropPath(imagePath),
                fit: BoxFit.cover,
                width: 60,
                height: 80,
              )))
      : ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            MovieConstants().roughImage,
            fit: BoxFit.cover,
            width: 60,
            height: 80,
          ));
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:movies_intent/components/widgets.dart';
import 'package:movies_intent/constants/movie_const.dart';
import 'package:movies_intent/models/movieModel.dart';
import 'package:movies_intent/screens/detailScreen.dart';
import 'package:movies_intent/screens/imageScreen.dart';
import 'package:movies_intent/services/apiCalls.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
class GridViewScreen extends StatefulWidget {
  final String category;
  GridViewScreen({this.category});

  @override
  _GridViewScreenState createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  Future<Welcome> _myData;
  List<Result> _movies;
  bool isLoading = false;
  int pageNumber = 1;
  ScrollController _controller;

  @override
  void initState() {
    isLoading = true;
    _myData = getMovieswithType(widget.category, pageNumber);
    _myData
        .then((value) => {
              setState(() {
                _movies = value.results;
                isLoading = false;
              })
            })
        .catchError((e) => {print(e)});
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      this.pageNumber++;
      _myData = getMovieswithType(widget.category, pageNumber);
      _myData.then((value) => {
            setState(() {
              _movies.addAll(value.results);
            })
          });
    }
    // if (_controller.offset <= _controller.position.minScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   print(_controller.offset);
    //   // setState(() {
    //   //   message = "reach the top";
    //   // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int randomNumber = random.nextInt(20);
    return Scaffold(
        body: isLoading
            ? Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Loading(
                      indicator: BallPulseIndicator(),
                      size: 100.0,
                      color: Colors.amber),
                ),
              )
            : CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: false,
                    expandedHeight: 150.0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      title: Text(
                        '${widget.category} Movies'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Nunito-Bold',
                          wordSpacing: 1.5,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                        ),
                      ),
                      background: Image.network(
                        MovieConstants().getBackdropPath(
                            _movies[randomNumber].backdropPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      tooltip: 'Back to screen',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                        crossAxisCount: 2,
                        // childAspectRatio: 8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int i) {
                        return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(255, 200, 55, 1),
                                      Color.fromRGBO(255, 128, 8, 1),
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.6),
                                      blurRadius: 2,
                                      spreadRadius: 0),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    posterWidget(context,
                                        _movies[i].backdropPath, _movies[i].id),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: voteAverage(
                                          _movies[i].voteAverage.toString()),
                                    ),
                                    Positioned(
                                        right: 0,
                                        bottom: 10,
                                        child: IconButton(
                                          icon: Icon(Icons.info_outline),
                                          enableFeedback: true,
                                          tooltip: 'Info about the movie',
                                          onPressed: () => {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    maintainState: true,
                                                    fullscreenDialog: true,
                                                    builder: (context) =>
                                                        DetailScreen(
                                                          movieId:
                                                              _movies[i].id,
                                                        )))
                                          },
                                          iconSize: 25,
                                        )),
                                  ],
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        _movies[i].title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: 'Nunito-Bold',
                                            fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        DateFormat('yyyy-MM-dd')
                                            .format(_movies[i].releaseDate)
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: Colors.white,
                                            fontFamily: 'Nunito-Light',
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ));
                      }, childCount: _movies.length)),
                  SliverToBoxAdapter(
                      child: Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Loading(
                          indicator: BallPulseIndicator(),
                          size: 100.0,
                          color: Colors.amber),
                    ),
                  )),
                ],
              ));
  }
}

Widget posterWidget(BuildContext context, String imagePath, int id) {
  return imagePath != null
      ? Container(
          child: InkWell(
            onLongPress: () => {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => ImageScreen(imagePath: imagePath)),
              ),
            },
            borderRadius: BorderRadius.circular(24),
            splashColor: Colors.amberAccent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageScreen(imagePath: imagePath)),
            ),
            child: Hero(
              tag: imagePath,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: FadeInImage.memoryNetwork(
                    // placeholderCacheHeight: 50,
                    // placeholderCacheWidth: 50,
                    fadeInCurve: Curves.easeIn,
                    fadeOutCurve: Curves.easeOut,
                    placeholder: kTransparentImage,
                    image: MovieConstants().getBackdropPath(imagePath),
                    height: 150,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        )
      : Container(
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            splashColor: Colors.amberAccent,
            onTap: () => null,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: FadeInImage.memoryNetwork(
                  placeholder:kTransparentImage,
                  image: MovieConstants().roughImage,
                  height: 150,
                  width: 200,
                  fit: BoxFit.cover,
                )),
          ),
        );
}

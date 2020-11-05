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

class GridViewScreen extends StatefulWidget {
  final String category;
  GridViewScreen({this.category});

  @override
  _GridViewScreenState createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  Future<Welcome> _myData;
  // List<Result> _movies;
  bool isLoading = false;

  int pageNumber = 1;
  @override
  void initState() {
    isLoading = true;
    _myData = getMovieswithType(widget.category, pageNumber);

    // _controller = ScrollController();
    // _controller.addListener(_scrollListener);
    super.initState();
  }

  ScrollController _controller;

  // _scrollListener() {
  //   if (_controller.offset >= _controller.position.maxScrollExtent &&
  //       !_controller.position.outOfRange) {
  //     this.pageNumber++;
  //     setState(() {
  //       _myData = getMovieswithType(widget.category, pageNumber);
  //     });
  //     print(_controller.offset);
  //   }
  //   // if (_controller.offset <= _controller.position.minScrollExtent &&
  //   //     !_controller.position.outOfRange) {
  //   //   print(_controller.offset);
  //   //   // setState(() {
  //   //   //   message = "reach the top";
  //   //   // });
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int randomNumber = random.nextInt(20);

    return Scaffold(
        body: FutureBuilder<Welcome>(
            future: _myData,
            builder: (BuildContext context, snapShot) {
              if (snapShot.hasData) {
                return CustomScrollView(
                  controller: _controller,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      snap: false,
                      expandedHeight: 150.0,
                      flexibleSpace: FlexibleSpaceBar(
                        // centerTitle: true,
                        collapseMode: CollapseMode.parallax,

                        title: Text(
                          '${widget.category} Movies'.toUpperCase(),
                          style: TextStyle(
                            wordSpacing: 1.5,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                          ),
                        ),
                        background: Image.network(
                          MovieConstants().getBackdropPath(
                              snapShot.data.results[randomNumber].backdropPath),
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
                            // childAspectRatio: 12 / 7,
                            crossAxisCount: 2),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int i) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.yellow,
                                        Colors.redAccent,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.6),
                                        blurRadius: 2,
                                        spreadRadius: 0),
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Stack(
                                    children: [
                                      InkWell(
                                        splashColor: Colors.amberAccent,
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ImageScreen(
                                                      imagePath: snapShot
                                                          .data
                                                          .results[i]
                                                          .backdropPath,
                                                    ))),
                                        child: Hero(
                                          tag: snapShot
                                              .data.results[i].backdropPath,
                                          child: Container(
                                            height: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              child: Image.network(
                                                MovieConstants()
                                                    .getBackdropPath(snapShot
                                                        .data
                                                        .results[i]
                                                        .backdropPath),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: voteAverage(snapShot
                                            .data.results[i].voteAverage
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  movieId: snapShot
                                                      .data.results[i].id,
                                                ))),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        snapShot.data.results[i].title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        }, childCount: snapShot.data.results.length))
                  ],
                );
              } else {
                // print(snapShot);
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Loading(
                        indicator: BallPulseIndicator(),
                        size: 100.0,
                        color: Colors.amber),
                  ),
                );
              }
            }));
  }
}

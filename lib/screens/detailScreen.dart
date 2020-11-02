import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:movies_intent/constants/movie_const.dart';
import 'package:movies_intent/models/movieDetailModel.dart';
import 'package:movies_intent/screens/imageScreen.dart';
import 'package:movies_intent/services/fetchMovieDetails.dart';

class DetailScreen extends StatefulWidget {
  final int movieId;

  DetailScreen({this.movieId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<Welcome> _myData;
  @override
  void initState() {
    _myData = fetchMovieDetail(widget.movieId);
    super.initState();
  }

  Widget _descriptionView(
    String title,
    String description,
    List<Genre> genres,
    double rating,
    String status,
    String tagline,
    String plot,
    dynamic releaseDate,
    bool adult,
    List<ProductionCompany> companies,
  ) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(
                child: Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Wrap(spacing: 2, children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  splashColor: Colors.amberAccent,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: adult ? Colors.redAccent : Colors.teal,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: Offset.fromDirection(0.5, 1)),
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        adult == true ? 'Adult' : 'Non Adult',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                )
              ]),
            )),
          ),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 5,
                children: genres.map((e) {
                  return InkWell(
                    splashColor: Colors.amberAccent,
                    enableFeedback: true,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.deepOrange[200],
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  offset: Offset.fromDirection(0.5, 1)),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          e.name,
                          style: TextStyle(color: Colors.white),
                        )),
                  );
                }).toList(),
              )),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(
                  'Rating: $rating / 10',
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: status == 'Released'
                            ? Colors.green
                            : Colors.deepOrange,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset.fromDirection(0.5, 1)),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      '$status',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(
                  'Released Date :',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  ' $releaseDate',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tagline',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  tagline.length > 0
                      ? Text(
                          tagline,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )
                      : Text('No Plot found'),
                ],
              )),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Movie Plot',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  plot.length > 0
                      ? Text(
                          plot,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )
                      : Text('No Plot found'),
                ],
              )),
          SizedBox(height: 20),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('Production Companies',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: companies.length > 0
                        ? Wrap(
                            spacing: 5,
                            children: companies.map((e) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                padding: EdgeInsets.all(10),
                                // alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          blurRadius: 2,
                                          spreadRadius: 0,
                                          offset: Offset.fromDirection(0.5, 1)),
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  e.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );

                              // e.logoPath != null ? Image.network(e.logoPath) : SizedBox(),
                            }).toList(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text('No Companies Found'),
                          ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Welcome>(
            future: _myData,
            builder: (BuildContext context, snapShot) {
              if (snapShot.hasData) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 300.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          snapShot.data.originalTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        background: snapShot.data.backdropPath != null
                            ? InkWell(
                                splashColor: Colors.amberAccent,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageScreen(
                                              imagePath:
                                                  snapShot.data.backdropPath,
                                            ))),
                                child: Hero(
                                  tag: snapShot.data.backdropPath,
                                  child: Image.network(
                                    MovieConstants().getBackdropPath(
                                        snapShot.data.backdropPath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : snapShot.data.posterPath != null
                                ? Image.network(
                                    MovieConstants()
                                        .getImagePath(snapShot.data.posterPath),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    MovieConstants().roughImage,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                      // background:

                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        tooltip: 'Back to screen',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SliverFixedExtentList(
                        itemExtent: 800,
                        delegate: SliverChildListDelegate([
                          _descriptionView(
                            snapShot.data.title,
                            snapShot.data.overview,
                            snapShot.data.genres,
                            snapShot.data.voteAverage,
                            snapShot.data.status,
                            snapShot.data.tagline,
                            snapShot.data.overview,
                            snapShot.data.releaseDate,
                            snapShot.data.adult,
                            snapShot.data.productionCompanies,
                          ),
                        ]))
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

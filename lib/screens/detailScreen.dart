import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:movies_intent/constants/movie_const.dart';
import 'package:movies_intent/models/movieDetailModel.dart';
import 'package:movies_intent/screens/imageScreen.dart';
import 'package:movies_intent/services/fetchMovieDetails.dart';
import 'package:url_launcher/url_launcher.dart';

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

  viewTrailer(String query) async {
    String url = 'https://www.youtube.com/results?search_query=$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
              alignment: Alignment.centerLeft,
              child: Wrap(alignment: WrapAlignment.start, children: [
                Container(
                    child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HindVadodara'),
                    ),
                    InkWell(
                      splashColor: Colors.amberAccent,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(5),
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
                            adult ? 'Adult' : 'Non Adult',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: "HindVadodara"),
                          )),
                    ),
                  ],
                )),
                FlatButton.icon(
                    color: Colors.white30,
                    onPressed: () => viewTrailer(title),
                    icon: Icon(Icons.video_label),
                    label: Text("Watch Trailer"))
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
                            color: e.id%2==0? Colors.deepOrange[200] : Colors.green[200],
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
            margin: EdgeInsets.symmetric(horizontal: 15.0),
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
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'Nunito-Light'),
                    )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(
                  'Released Date : ',
                  style: TextStyle(fontSize: 20, fontFamily: 'Nunito-Bold'),
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(releaseDate).toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Nunito-Light'),
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
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Bold'),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  tagline.length > 0
                      ? Text(
                          tagline,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Nunito-Light'),
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
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Bold'),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  plot.length > 0
                      ? Text(
                          plot,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Nunito-Light'),
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito-Bold'))),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: companies.length > 0
                        ? Wrap(
                            children: companies.map((e) {
                              return Container(
                                height: 50,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.white38,
                                          e.id % 2 == 0
                                              ? Colors.amberAccent
                                              : Colors.redAccent,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          blurRadius: 2,
                                          spreadRadius: 0,
                                          offset: Offset.fromDirection(0.5, 1)),
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // Text(e.originCountry),
                                    e.logoPath != null
                                        ? Image.network(
                                            MovieConstants()
                                                .getImagePath(e.logoPath),
                                            width: 30,
                                            height: 30,
                                          )
                                        : SizedBox(),

                                    e.name.length > 12
                                        ? Text(
                                            e.name.substring(0, 11),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Nunito-Light',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            e.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Nunito-Light',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ],
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
                              fontFamily: 'HindVadodara'),
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
                        itemExtent: 1000,
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

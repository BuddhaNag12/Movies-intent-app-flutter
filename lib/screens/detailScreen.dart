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
  Future<MovieDetailModel> _myData;
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

  Widget _companyView(List<ProductionCompany> companies) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Text('Production Companies',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Bold'))),
            Divider(
              height: 10,
              thickness: 1,
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: companies.length > 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Wrap(
                          children: companies.map((e) {
                            return Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2 - 20,
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
                                  e.logoPath != null
                                      ? Image.network(
                                          MovieConstants()
                                              .getBackdropPath(e.logoPath),
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
                          }).toList(),
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('No Companies Found'),
                    ),
            ),
          ],
        ));
  }

  Widget moreDetailsView(
      List<SpokenLanguage> spokenLanguages,
      List<ProductionCountry> countries,
      int budget,
      dynamic collection,
      int runtime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    "Languages:",
                    style: TextStyle(fontFamily: 'HindVadodara', fontSize: 25),
                  )),
              Divider(
                height: 10,
                thickness: 1,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 5,
                    children: spokenLanguages.map((e) {
                      return InkWell(
                        splashColor: Colors.amberAccent,
                        enableFeedback: true,
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
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
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    "Production Countries:",
                    style: TextStyle(fontFamily: 'HindVadodara', fontSize: 25),
                  )),
              Divider(
                height: 10,
                thickness: 1,
              ),
              countries.length > 0
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 5,
                        children: countries.map((e) {
                          return InkWell(
                            splashColor: Colors.amberAccent,
                            enableFeedback: true,
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
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
                      ))
                  : Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Text("No Countries Found"),
                      ),
                    ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Text(
                        "Budget : $budget",
                        style:
                            TextStyle(fontFamily: "Nunito-Bold", fontSize: 20),
                      )),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Text(
                        "Runtime : $runtime - min",
                        style:
                            TextStyle(fontFamily: "Nunito-Bold", fontSize: 20),
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
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
    String originalTitle,
  ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Wrap(children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito-Bold'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
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
                              fontFamily: "Nunito-Bold"),
                        )),
                  ),
                ]),
              )),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FlatButton.icon(
                onPressed: () => viewTrailer(originalTitle),
                icon: Icon(Icons.video_label),
                label: Text("Watch Trailer")),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Genres",
                      style: TextStyle(fontSize: 20, fontFamily: "Nunito-Bold"),
                    ),
                  ),
                  Wrap(
                    spacing: 5,
                    children: genres.map((e) {
                      return InkWell(
                        splashColor: Colors.amberAccent,
                        enableFeedback: true,
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: e.id % 2 == 0
                                    ? Colors.deepOrangeAccent[200]
                                    : Colors.lightBlueAccent[200],
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
                  ),
                ],
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
                      : Text('No Tagline found'),
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
                          overflow: TextOverflow.ellipsis,
                          maxLines: 12,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Nunito-Light'),
                        )
                      : Text('No Plot found'),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: FutureBuilder<MovieDetailModel>(
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
                            snapShot.data.originalTitle.length > 20
                                ? snapShot.data.originalTitle.substring(0, 20)
                                : snapShot.data.originalTitle,
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
                                      MovieConstants().getBackdropPath(
                                          snapShot.data.posterPath),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      MovieConstants().roughImage,
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
                      SliverFixedExtentList(
                          delegate: SliverChildListDelegate([
                            TabBar(
                              labelStyle: TextStyle(
                                  fontFamily: "Nunito-Bold", fontSize: 15),
                              indicatorColor: Colors.amberAccent,
                              tabs: [
                                Tab(
                                  text: "Description",
                                  icon: Icon(Icons.info_rounded),
                                ),
                                Tab(
                                  text: "Companies",
                                  icon: Icon(Icons.business_rounded),
                                ),
                                Tab(
                                  text: "Furthur Details",
                                  icon: Icon(Icons.perm_device_info_outlined),
                                ),
                              ],
                            ),
                          ]),
                          itemExtent: 60),
                      SliverFillViewport(
                          // padEnds: true,

                          delegate: SliverChildListDelegate([
                        TabBarView(children: [
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
                            snapShot.data.originalTitle,
                          ),
                          _companyView(snapShot.data.productionCompanies),
                          moreDetailsView(
                            snapShot.data.spokenLanguages,
                            snapShot.data.productionCountries,
                            snapShot.data.budget,
                            snapShot.data.belongsToCollection,
                            snapShot.data.runtime,
                          ),
                        ]),
                      ])),
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
              })),
    );
  }
}

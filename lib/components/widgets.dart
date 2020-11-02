import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:movies_intent/constants/movie_const.dart';
import 'package:movies_intent/models/movieModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_intent/screens/detailScreen.dart';

// global Appbar

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function _showButtomSheet;

  MyAppBar(this._showButtomSheet);

  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'LOGO.png',
        width: 150,
        height: 150,
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.menu),
        // color: Colors,
        onPressed: () => {_showButtomSheet()},
      ),
      actions: [
        Container(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.search),
                enableFeedback: true,
                tooltip: 'Head toward search Screen',
                onPressed: () => {Navigator.pushNamed(context, '/Search')},
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class Carousel extends StatefulWidget {
  final List<Result> payload;
  Carousel(this.payload);
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          // height: 400,
          viewportFraction: 0.7,
        ),
        items: widget.payload.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                // padding: EdgeInsets.all(10),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 0,
                          offset: Offset(0, 2)),
                    ]),
                child: Container(
                  alignment: Alignment.center,
                  child: posterWidget(context, i.posterPath, i.id),
                ),
              );
            },
          );
        }).toList());
  }
}

Widget titleWidget(String title) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
    ),
  );
}

Widget posterWidget(BuildContext context, String imagePath, int id) {
  return imagePath != null
      ? GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(movieId: id)),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(MovieConstants().getImagePath(imagePath),
                  width: 300, height: 200, fit: BoxFit.cover)),
        )
      : ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
              fit: BoxFit.cover));
}

Widget headingContent(Future<Welcome> _myData) {
  return FutureBuilder<Welcome>(
    future: _myData,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Carousel(snapshot.data.results);
      } else {
        return Center(
          child: Loading(
              indicator: BallPulseIndicator(), size: 50.0, color: Colors.amber),
        );
      }
    },
  );
}

Widget listView(BuildContext context, List<Result> listitems) {
  return ListView.builder(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    scrollDirection: Axis.horizontal,
    itemCount: listitems.length,
    itemBuilder: (_, i) {
      return InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        splashColor: Colors.amber,
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(movieId: listitems[i].id)))
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [
                  Colors.yellow,
                  Colors.redAccent,
                ], begin: Alignment.topLeft, end: Alignment.centerRight),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      blurRadius: 2,
                      spreadRadius: 0),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: listitems[i].posterPath != null
                          ? Image.network(
                              MovieConstants()
                                  .getImagePath(listitems[i].posterPath),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : listitems[i].backdropPath != null
                              ? Image.network(
                                  MovieConstants().getBackdropPath(
                                      listitems[i].backdropPath),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  MovieConstants().roughImage,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: voteAverage(listitems[i].voteAverage.toString()),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    listitems[i].title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
                // Text(
                //   listitems[i].releaseDate.toString(),
                //   overflow: TextOverflow.ellipsis,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       fontWeight: FontWeight.w200,
                //       color: Colors.white,
                //       fontSize: 12),
                // ),
              ],
            )),
      );
    },
  );
}

Widget voteAverage(String vote) {
  return Container(
    child: Text(
      '$vote / 10',
      style: TextStyle(color: Colors.white),
    ),
  );
}

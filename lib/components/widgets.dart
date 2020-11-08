import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:movies_intent/constants/movie_const.dart';
import 'package:movies_intent/models/movieModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_intent/screens/detailScreen.dart';
import 'package:movies_intent/screens/gridViewScreen.dart';
import 'package:movies_intent/screens/searchScreen.dart';
import 'package:transparent_image/transparent_image.dart';

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
      backgroundColor: Colors.transparent,
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
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        fullscreenDialog: true,
                        maintainState: true,
                        builder: (context) => SearchScreen())),
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
          autoPlayCurve: Curves.easeInOut,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
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
                          color: Colors.black45.withOpacity(0.2),
                          blurRadius: 4,
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
                MaterialPageRoute(
                    builder: (context) => DetailScreen(movieId: id)),
              ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: FadeInImage.memoryNetwork(
                placeholderCacheHeight: 20,
                placeholderCacheWidth: 20,
                fadeInCurve: Curves.easeIn,
                placeholder: kTransparentImage,
                image: MovieConstants().getImagePath(imagePath),
                fit: BoxFit.cover,
                width: 300,
                height: 200,
              )))
      : ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(MovieConstants().roughImage, fit: BoxFit.cover));
}

Widget headingContent(Future<Welcome> _myData) {
  return FutureBuilder<Welcome>(
    future: _myData,
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(
            child: Loading(
                indicator: BallPulseIndicator(),
                size: 50.0,
                color: Colors.amber),
          );
          break;
        case ConnectionState.none:
          return Center(child: Text('No internet connection'));

        default:
          if (snapshot.hasData) {
            return Carousel(snapshot.data.results);
          } else {
            return Center(
              child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 50.0,
                  color: Colors.amber),
            );
          }
      }
    },
  );
}

class ListViewWidget extends StatefulWidget {
  final List<Result> listitems;
  final _scrollDirection;
  ListViewWidget(this.listitems, this._scrollDirection);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  // var top = 0.0;
  // var right = 0.0;

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     setState(() {
  //       top = 10;
  //       right = 20;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      scrollDirection: widget._scrollDirection,
      itemCount: widget.listitems.length,
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
                    builder: (context) =>
                        DetailScreen(movieId: widget.listitems[i].id)))
          },
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(255, 200, 55, 1),
                    Color.fromRGBO(255, 128, 8, 1),
                  ], begin: Alignment.bottomLeft, end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        blurRadius: 2,
                        spreadRadius: 0),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: widget.listitems[i].posterPath != null
                            ? FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                placeholderCacheHeight: 50,
                                placeholderCacheWidth: 150,
                                fadeInCurve: Curves.easeIn,
                                fadeOutCurve: Curves.easeOut,
                                image: MovieConstants().getImagePath(
                                    widget.listitems[i].posterPath),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : widget.listitems[i].backdropPath != null
                                ? Image.network(
                                    MovieConstants().getBackdropPath(
                                        widget.listitems[i].backdropPath),
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
                      right: 20,
                      top: 10,
                      child: voteAverage(
                          widget.listitems[i].voteAverage.toString()),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.listitems[i].title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Nunito-Light',
                          fontSize: 14),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

Widget voteAverage(String vote) {
  return Container(
    child: Text(
      '$vote / 10',
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget loader() {
  return Center(
    child: Loading(
        indicator: BallPulseIndicator(), size: 50.0, color: Colors.amber),
  );
}

Widget separatorWidget(context, String title, String route) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito-Bold')),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 1.0,
            width: MediaQuery.of(context).size.width / 2 + 50,
            color: Colors.redAccent,
          ),
          InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      fullscreenDialog: true,
                      maintainState: true,
                      builder: (context) => GridViewScreen(category: route))),
              splashColor: Colors.amberAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('View all'),
              )),
        ],
      )
    ],
  );
}

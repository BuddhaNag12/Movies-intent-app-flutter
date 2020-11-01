import 'package:carousel_slider/carousel_slider.dart';
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
      backgroundColor: Colors.transparent,
      // brightness: Brightness.light,
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
                // color: Colors.black,
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
          enlargeCenterPage: true,
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
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          blurRadius: 8,
                          spreadRadius: 0),
                    ]),
                child: Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    child: posterWidget(context, i.posterPath, i.id),
                  ),
                  Positioned(
                    top: 153,
                    right: 10,
                    left: 10,
                    child: Container(
                        width: 220,
                        margin: EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color.fromRGBO(100, 100, 100, 0.8)),
                        child: SizedBox(
                            width: 220,
                            height: 50,
                            child: titleWidget(i.title))),
                  )
                ]),
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
                  width: 300, height: 200, fit: BoxFit.fitWidth)),
        )
      : ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
              fit: BoxFit.fitWidth));
}

Widget headingContent(Future<Welcome> _myData) {
  return FutureBuilder<Welcome>(
    future: _myData,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Carousel(snapshot.data.results);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

// InkWell(
//                 onTap: () => ,child:),
Widget listView(BuildContext context, List<Result> listitems) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: listitems.length,
    // itemExtent: 200,
    itemBuilder: (_, i) {
      return InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.amberAccent,
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(movieId: listitems[i].id)),
          )
        },
        child: Container(
          width: 140,
          // height: 180,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: listitems[i].posterPath != null
                      ? Image.network(
                          MovieConstants()
                              .getImagePath(listitems[i].posterPath),
                        )
                      : listitems[i].backdropPath != null
                          ? Image.network(MovieConstants()
                              .getBackdropPath(listitems[i].backdropPath))
                          : Image.network(MovieConstants().roughImage),
                ),
              ),
              Positioned(
                right: 20,
                top: 10,
                child: voteAverage(listitems[i].voteAverage.toString()),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                left: 20,
                child: SizedBox(
                  width: 150,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      listitems[i].title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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

// Column(children: [
//             SizedBox(
//               width: 300,
//               height: 300,
//               child: Container(
//                 alignment: Alignment.centerRight,
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24),
//                     gradient: LinearGradient(colors: [
//                       Colors.yellow,
//                       Colors.redAccent,
//                     ], begin: Alignment.topLeft, end: Alignment.centerRight),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color.fromRGBO(0, 0, 0, 0.6),
//                           blurRadius: 2,
//                           spreadRadius: 0),
//                     ]),
//                 // child: ClipRRect(

//                 //   borderRadius: BorderRadius.circular(24),
//                 //   child: Image.network(
//                 //     MovieConstants()
//                 //         .getImagePath(listitems.data.results[i].posterPath),
//                 //   ),
//                 // ),
//               ),
//             ),
// Text(
//   listitems.data.results[i].title,
//   overflow: TextOverflow.ellipsis,
//   textAlign: TextAlign.start,
//   style: TextStyle(fontWeight: FontWeight.normal),
// )
//           ]),

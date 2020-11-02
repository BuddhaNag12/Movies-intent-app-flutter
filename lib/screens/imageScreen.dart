import 'package:flutter/material.dart';
import 'package:movies_intent/constants/movie_const.dart';
// import 'package:flutter/services.dart';

class ImageScreen extends StatefulWidget {
  final String imagePath;
  ImageScreen({this.imagePath});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var boxfit = BoxFit.cover;

  changeFit() {

    setState(() {
      boxfit== BoxFit.contain ? boxfit= BoxFit.cover : boxfit=BoxFit.contain;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Hero(
          tag: widget.imagePath,
          child: Image.network(
            MovieConstants().getBackdropPath(widget.imagePath),
            fit: boxfit,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.amber,
              elevation: 5,
              splashColor: Colors.amberAccent,
              onPressed: changeFit,
              child: Icon(
                Icons.square_foot_rounded,
                color: Colors.white,
              ),
            )),
        Positioned(
            top: 20,
            left: 5,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            )),
      ]),
    );
  }
}

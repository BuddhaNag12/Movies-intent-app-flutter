import 'package:flutter/material.dart';
import 'package:movies_intent/constants/movie_const.dart';

class ImageScreen extends StatefulWidget {
  final String imagePath;
  ImageScreen({this.imagePath});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var _boxfit = BoxFit.cover;

  changeFit() {
    setState(() {
      _boxfit == BoxFit.contain
          ? _boxfit = BoxFit.cover
          : _boxfit = BoxFit.contain;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        elevation: 5,
        splashColor: Colors.amberAccent,
        onPressed: changeFit,
        child: Icon(
          Icons.crop_16_9_outlined,
          color: Colors.white,
        ),
      ),
      body: Stack(children: [
        Hero(
          tag: widget.imagePath,
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(20.0),
            // minScale:1.0,
            maxScale: 5.0,
            child: Image.network(
              MovieConstants().getBackdropPath(widget.imagePath),
              fit: _boxfit,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
        ),
        Positioned(
            top: 25,
            left: 5,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            )),
        // Positioned(
        //     bottom: 20,
        //     left: 10,
        //     child: IconButton(
        //       onPressed: _downloadImage,
        //       icon: Icon(Icons.download_rounded),
        //       color: Colors.white,
        //     )),
      ]),
    );
  }
}

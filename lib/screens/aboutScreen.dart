import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_intent/constants/movie_const.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  _launchURL() async {
    const url = 'https://github.com/BuddhaNag12/Movies-intent-app-flutter';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLSecond() async {
    const url = 'mailto:rahulnag514@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLProfile() async {
    const url = 'https://www.facebook.com/ItSBuddhaHERE/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _apiWebsite() async {
    const url = 'https://developers.themoviedb.org/3/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Image.asset(
              'assets/about.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(3),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.blueGrey[200],
                        Colors.amberAccent[200]
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45.withOpacity(0.2),
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 2)),
                      ]),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'About The developer',
                        style: TextStyle(
                            fontSize: 24.0, fontFamily: 'HindVadodara'),
                      )),
                ),
                GestureDetector(
                  onTap: _launchURLProfile,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.blueGrey[200],
                              Colors.amberAccent[200]
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 2))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            MovieConstants().developerImage,
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text('Buddha Nag'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildTextWidget(),
            Divider(
              height: 2,
            ),
            buildProjectWidget(_launchURL),
            Divider(
              height: 2,
            ),
            buildContactWidget(_launchURLSecond),
            buildApiWidget(_apiWebsite),
          ],
        ),
      )),
    );
  }
}

Widget buildContactWidget(_launchURLSecond) {
  return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Contact Details :',
            style: TextStyle(fontSize: 20.0, fontFamily: 'HindVadodara'),
          )),
      Row(
        children: [
          Text(
            "Email me at",
            style: TextStyle(
                fontSize: 15,
                letterSpacing: 0.5,
                fontFamily: 'Nunito-Light',
                fontWeight: FontWeight.w600),
          ),
          FlatButton.icon(
              onPressed: _launchURLSecond,
              icon: Icon(Icons.email),
              label: Text('Gmail'))
        ],
      )
    ],
  ));
}

Widget buildApiWidget(_apiWebsite) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Api used :',
            style: TextStyle(fontSize: 20.0, fontFamily: 'HindVadodara'),
          )),
      Row(
        children: [
          Text(
            "The Movie Database :",
            style: TextStyle(
                fontSize: 15,
                letterSpacing: 0.5,
                fontFamily: 'Nunito-Light',
                fontWeight: FontWeight.w600),
          ),
          FlatButton.icon(
              onPressed: _apiWebsite,
              icon: Icon(Icons.api_rounded),
              label: Text('Api'))
        ],
      )
    ],
  ));
}

Widget buildProjectWidget(_launchURL) {
  return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Project Details:',
            style: TextStyle(fontSize: 20.0, fontFamily: 'HindVadodara'),
          )),
      Text(
        "You can find my project licence and project source code in github below",
        style: TextStyle(
            fontSize: 15,
            letterSpacing: 0.5,
            fontFamily: 'Nunito-Light',
            fontWeight: FontWeight.w600),
      ),
      FlatButton.icon(
          color: Colors.white30,
          onPressed: _launchURL,
          icon: Icon(Icons.account_tree_outlined),
          label: Text('Github'))
    ],
  ));
}

Widget buildTextWidget() {
  return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quick Summary :',
            style: TextStyle(fontSize: 20.0, fontFamily: 'HindVadodara'),
          )),
      Text(
        "Hi...! I'm a full stack web developer and software developer",
        style: TextStyle(
            fontSize: 15,
            letterSpacing: 0.5,
            fontFamily: 'Nunito-Light',
            fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 5),
      Text(
          "working on simultaneous projects on react native , flutter and vuejs",
          style: TextStyle(
              fontSize: 15,
              letterSpacing: 0.5,
              fontFamily: 'Nunito-Light',
              fontWeight: FontWeight.w600)),
      SizedBox(height: 5),
      Text(
          "I'm very passionate and hard working guy love programing and coding all",
          style: TextStyle(
              fontSize: 15,
              letterSpacing: 0.5,
              fontFamily: 'Nunito-Light',
              fontWeight: FontWeight.w600)),
      SizedBox(height: 5),
      Text(
          "I'm currently working and contributing to a private company i.e Working under Krypto developers pvt ltd.",
          style: TextStyle(
              fontSize: 15,
              letterSpacing: 0.5,
              fontFamily: 'Nunito-Light',
              fontWeight: FontWeight.w600))
    ],
  ));
}

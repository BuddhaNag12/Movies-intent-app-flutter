import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:movies_intent/components/widgets.dart';
import 'package:movies_intent/models/movieModel.dart';
import 'package:movies_intent/services/apiCalls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Welcome> _myData;
  Future<Welcome> _upcoming;
  bool isLoading = true;
  @override
  void initState() {
    isLoading = true;
    _myData = fetchMovies();
    _upcoming = fetchUpcomingMovies();
    fetchMovies().then((val) => {
          fetchUpcomingMovies().then((value) => {
                setState(() => {isLoading = false})
              })
        });
    super.initState();
  }

  void showbottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      elevation: 5,
      builder: (BuildContext context) {
        return Container(
          height: 240,
          child: ListView(
            padding: EdgeInsets.all(5),
            children: <Widget>[
              Center(
                  child: Text('Click outside to close',
                      style: TextStyle(fontSize: 18))),
              Divider(
                color: Colors.black45,
              ),
              Column(
                children: [
                  FlatButton(
                    onPressed: () => {Navigator.pushNamed(context, "/About")},
                    child: ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('About'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => {Navigator.pushNamed(context, "/Help")},
                    child: ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text('Help'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop'),
                    child: ListTile(
                      leading: Icon(Icons.close),
                      title: Text('Close App'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(showbottomSheet),
      body: isLoading
          ? Center(
              child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 50.0,
                  color: Colors.amber),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  headingContent(_myData),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 10),
                            child: Text('Upcoming Movies',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width / 2,
                              color: Colors.redAccent,
                            ),
                          ),
                          InkWell(
                              splashColor: Colors.amberAccent,
                              child: Text('View all')),
                        ],
                      ),
                      HorizontalList(_upcoming),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 10),
                            child: Text('Most Popular',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width / 2,
                              color: Colors.redAccent,
                            ),
                          ),
                          InkWell(child: Text('View all')),
                        ],
                      ),
                      HorizontalList(_myData),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  final Future<Welcome> movies;
  HorizontalList(this.movies);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Welcome>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                height: 250,
                // color: Colors.red,
                child: listView(context, snapshot.data.results));
          } else {
            return Center(
              child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 50.0,
                  color: Colors.amber),
            );
          }
        });
  }
}

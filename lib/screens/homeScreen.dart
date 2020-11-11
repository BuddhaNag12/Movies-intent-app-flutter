import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
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
  Future<Iterable<Result>> _movies;
  List<Result> _listOfMovies;
  List<Result> _upComing;
  bool _isLoading = false;
  DateTime currentDate = new DateTime.now();
  String _error;

  @override
  void initState() {
    _isLoading = true;
    _movies = fetchData();
    onRefreshCall();
    super.initState();
  }

  Future<void> onRefreshCall() async {
    await _movies
        .then((value) => {
              setState(() {
                _listOfMovies =
                    value.where((element) => element.voteAverage >= 7).toList();
                _upComing = value
                    .where((element) =>
                        currentDate.year >= element.releaseDate.year)
                    .toList();
                _isLoading = false;
                return;
              })
            })
        .catchError((E) => {
              setState(() {
                _isLoading = false;
                _error = E;
                return;
              })
            });
    return;
  }

  void showbottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: 220,
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
                    onPressed: () =>
                        AdaptiveTheme.of(context).toggleThemeMode(),
                    child: ListTile(
                      leading: Icon(Icons.settings_brightness),
                      title: Text('Dark Mode'),
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
    return _isLoading
        ? Scaffold(body: loader())
        : _error != null
            ? Scaffold(
                body: Center(
                child: Text("Opps Error occured $_error"),
              ))
            : Scaffold(
                appBar: MyAppBar(showbottomSheet),
                body: RefreshIndicator(
                  onRefresh: onRefreshCall,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(children: [
                        Carousel(_listOfMovies),
                        separatorWidget(context, 'Most Rated', 'popular'),
                        Container(
                            height: 250,
                            child:
                                ListViewWidget(_listOfMovies, Axis.horizontal)),
                        separatorWidget(context, 'Top Movies', 'upcoming'),
                        Container(
                            height: 250,
                            child: ListViewWidget(_upComing, Axis.horizontal)),
                      ]),
                    ),
                  ),
                ),
              );
  }
}

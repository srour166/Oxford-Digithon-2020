import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

final Color accentBackgroundColor = const Color(0xFF7de3fa);
final Color midBackgroundColor = const Color(0xFF2f1cff);

class MyDashboardPage extends StatefulWidget {
  MyDashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: <Widget>[dashboard(context)],
        ));
  }

  Widget dashboard(context) {
    return Material(
      elevation: 8,
      color: Colors.blue,
      child: Column(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              // background gradient
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [accentBackgroundColor, midBackgroundColor])),
        ),
        Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
            // color: Colors.pink,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // dashboard
              children: <Widget>[
                Text(
                  "DASHBOARD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontFamily: "Open Sans"),
                ),
              ],
            )),
        Container(
          // color: Colors.red,
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 36,
                top: 48,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "5",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontFamily: 'Open Sans'),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "TO DO",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Open Sans'),
                    ),
                  ],
                ),
              ),
              Center(
                // CIRCLE PERCENTAGE
                child: CircularPercentIndicator(
                  radius: 130.0,
                  backgroundColor: Colors.white38,
                  lineWidth: 3.0,
                  percent: 0.66,
                  progressColor: Colors.white,
                  center: Container(
                    padding: const EdgeInsets.only(top: 32),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "3",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                                color: Colors.white,
                                letterSpacing: 1,
                                fontFamily: 'Open Sans'),
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            "COMPLETED",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontFamily: 'Open Sans'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 42,
                top: 48,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontFamily: 'Open Sans'),
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        "DONE",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'Open Sans'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            // color: Colors.green,
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontFamily: 'Open Sans'),
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        "SOCIAL",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontFamily: 'Open Sans'),
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "4",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontFamily: 'Open Sans'),
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        "PHYSICAL",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontFamily: 'Open Sans'),
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontFamily: 'Open Sans'),
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        "MENTAL",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontFamily: 'Open Sans'),
                      ),
                    )
                  ],
                ),
              ],
            )), // categories
        Container(
            child: Column(
          children: <Widget>[
            Card(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text("Cook", style: TextStyle(fontSize: 18.0)),
                              SizedBox(height: 6),
                              Text("Make dinner for you and your family.",
                                  style: TextStyle(fontSize: 10.0)),
                            ]),
                        Padding(
                            padding: const EdgeInsets.only(left: 280),
                            child: Icon(
                              Icons.public,
                              size: 40,
                            )),
                      ],
                    ))),
            Card(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text("Workout", style: TextStyle(fontSize: 18.0)),
                              SizedBox(height: 6),
                              Text("Exercise for 30 minutes today.",
                                  style: TextStyle(fontSize: 10.0)),
                            ]),
                        Padding(
                            padding: const EdgeInsets.only(left: 280),
                            child: Icon(
                              Icons.directions_walk,
                              size: 40,
                            )),
                      ],
                    ))),
            Card(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text("Meditate",
                                  style: TextStyle(fontSize: 18.0)),
                              SizedBox(height: 6),
                              Text("Take some time to relax and meditate.",
                                  style: TextStyle(fontSize: 10.0)),
                            ]),
                        Padding(
                            padding: const EdgeInsets.only(left: 280),
                            child: Icon(
                              Icons.sentiment_very_satisfied,
                              size: 40,
                            )),
                      ],
                    ))),
            Card(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text("Read", style: TextStyle(fontSize: 18.0)),
                              SizedBox(height: 6),
                              Text("Read a book or a magazine.",
                                  style: TextStyle(fontSize: 10.0)),
                            ]),
                        Padding(
                            padding: const EdgeInsets.only(left: 280),
                            child: Icon(
                              Icons.book,
                              size: 40,
                            )),
                      ],
                    ))),
          ],
        ))
      ]),
    );
  }
}

/*
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.blue])),
*/

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Stopwatch watch = new Stopwatch();

  Timer timer;

  String elapsedTime = '';

  updateTime(Timer timer) {
    setState(() {
      elapsedTime = transformMillisecond(watch.elapsedMilliseconds);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("StopWatch"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.bug_report),
              onPressed: () => {},
            )
          ],
        ),
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new Text(
                elapsedTime,
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(height: 30.0,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new FloatingActionButton(
                    onPressed: startWatch,
                    backgroundColor: Colors.green,
                    child: new Icon(Icons.play_arrow),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  new FloatingActionButton(
                    onPressed: stopWatch,
                    backgroundColor: Colors.red,
                    child: new Icon(Icons.stop),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  new FloatingActionButton(
                    onPressed: resetWatch,
                    backgroundColor: Colors.blue,
                    child: new Icon(Icons.refresh),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  startWatch() {
    watch.start();
    timer = new Timer.periodic(new Duration(milliseconds: 100), updateTime);
  }

  stopWatch() {
    watch.stop();
    setTime();
  }

  resetWatch() {
    watch.reset();
    setTime();
  }

  setTime() {
    setState(() {
      elapsedTime = transformMillisecond(watch.elapsedMilliseconds);
    });
  }

  transformMillisecond(int milliseconds) {

    //Thanks to Andrew

    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2,'0');
    String secondsStr = (seconds % 60).toString().padLeft(2,'0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2,'0');

    return "$minutesStr:$secondsStr:$hundredsStr";
  }

}

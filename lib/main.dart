import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Stopwatch for DC 프갤 61.77'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var twoZeroNumberFormatter = new NumberFormat("00");

  int hour = 0;
  int minute = 0;
  int second = 0;
  int centisecond = 0;

  String buttonState = '시작';
  Stopwatch stopwatch = new Stopwatch();
  Timer timer;

  _MyHomePageState() {
    timer = new Timer.periodic(new Duration(milliseconds: 10), _onTimer);
  }

  void updateTime() {
    if (stopwatch.isRunning) {
      var elapsedMs = stopwatch.elapsedMilliseconds;
      centisecond = elapsedMs % 1000 ~/ 10;
      second = elapsedMs ~/ 1000 % 60;
      minute = elapsedMs ~/ 1000 ~/ 60 % 60;
      hour = elapsedMs ~/1000 ~/ 60 ~/ 60;
    }
  }

  void _onTimer(Timer timer) {
    setState(() {
      updateTime();
    });
  }

  void _onButtonPressed() {
    setState(() {
      if (!stopwatch.isRunning) {
        stopwatch.start();
        buttonState = "정지";
      } else {
        stopwatch.stop();
        buttonState = "시작";
      }
    });
  }

  void _onResetPressed() {
    setState(() {
      stopwatch.reset();
      hour = minute = second = centisecond = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/ssammu.jpeg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(twoZeroNumberFormatter.format(hour), textScaleFactor: 4, style: TextStyle(color: Colors.white)),
                    Text(':', textScaleFactor: 4, style: TextStyle(color: Colors.white)),
                    Text(twoZeroNumberFormatter.format(minute), textScaleFactor: 4, style: TextStyle(color: Colors.white)),
                    Text(':', textScaleFactor: 4, style: TextStyle(color: Colors.white)),
                    Text(twoZeroNumberFormatter.format(second), textScaleFactor: 4, style: TextStyle(color: Colors.white)),
                    Text('.', textScaleFactor: 4, style: TextStyle(color: Colors.white)),
                    Text(twoZeroNumberFormatter.format(centisecond), textScaleFactor: 4, style: TextStyle(color: Colors.white)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('$buttonState'),
                      onPressed: _onButtonPressed,
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      child: Text('초기화'),
                      onPressed: _onResetPressed,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,

                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
          )
        )
      );
  }
}

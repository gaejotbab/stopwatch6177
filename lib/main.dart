import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Stopwatch for DC 프갤 61.77'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var twoZeroNumberFormatter = new NumberFormat("00");

  String buttonState = '시작';
  Stopwatch stopwatch = new Stopwatch();
  Timer timer;

  List<String> recordedTimes = [];
  bool isStoppedTimeRecorded = false;

  _MyHomePageState() {
    timer = new Timer.periodic(new Duration(milliseconds: 10), _onTimer);
  }

  void _onTimer(Timer timer) {
    setState(() {
    });
  }

  void _onButtonPressed() {
    setState(() {
      if (!stopwatch.isRunning) {
        isStoppedTimeRecorded = false;
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
      recordedTimes.clear();
    });
  }

  String formattedElapsedTime() {
    var elapsedMs = stopwatch.elapsedMilliseconds;
    var centisecond = elapsedMs % 1000 ~/ 10;
    var second = elapsedMs ~/ 1000 % 60;
    var minute = elapsedMs ~/ 1000 ~/ 60 % 60;
    var hour = elapsedMs ~/1000 ~/ 60 ~/ 60;
    var formattedTime = twoZeroNumberFormatter.format(hour)
        + ':'
        + twoZeroNumberFormatter.format(minute)
        + ':'
        + twoZeroNumberFormatter.format(second)
        + ':'
        + twoZeroNumberFormatter.format(centisecond);

    return formattedTime;
  }

  void _onRecordPressed() {
    if (stopwatch.isRunning) {
      recordedTimes.add(formattedElapsedTime());
    } else {
      if (!isStoppedTimeRecorded) {
        recordedTimes.add(formattedElapsedTime());
        isStoppedTimeRecorded = true;
      }
    }
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
                Builder(builder: (context) =>
                  DefaultTextStyle(
                    style: DefaultTextStyle.of(context)
                        .style.apply(fontSizeFactor: 4, color: Colors.white),
                    child: Row(
                      children: <Widget>[
                        Text(formattedElapsedTime()),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  )
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text(buttonState),
                      onPressed: _onButtonPressed,
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      child: Text('기록'),
                      onPressed: _onRecordPressed,
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      child: Text('초기화'),
                      onPressed: _onResetPressed,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 20),
                Builder(builder: (context) =>
                  DefaultTextStyle(
                    style: DefaultTextStyle.of(context)
                        .style.apply(fontSizeFactor: 2.5, color: Colors.white),
                    child: Container(
                      height: 250,
                      child: ListView.builder(
                        itemCount: recordedTimes.length,
                        itemBuilder: (context, index) => Text(
                            recordedTimes[recordedTimes.length - index - 1],
                            textAlign: TextAlign.center
                        ),
                      )
                    )
                  )
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
          )
        )
      );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform =
      const MethodChannel("test.flutter.legends/sendMessage");

  String incomingMessage = "incoming Empty...";
  String _message = "message from flutter.";

  Future<void> _getMessage() async {
    String message;
    try {
      final String result = await platform.invokeMethod('getMessage');
      message = result;
    } on PlatformException catch (e) {
      message = "Error: unable to call method ...";
    }
    _message = message;

    setState(() {
      incomingMessage = _message;
    });
  }

  String outgoingMessage = "outgoing Empty...";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(
                    incomingMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    outgoingMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      onSubmitted: (String message) {
                        setState(() {
                          outgoingMessage = message;
                        });
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'getMessage',
                    ),
                    onPressed: _getMessage,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

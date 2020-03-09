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

  Future<void> _sendMessage(String message) async {
    String eval;
    try {
      final String result =
          await platform.invokeMethod('sendMessage', <String, dynamic>{
        "message_flutter": message,
      });
      eval = result;
    } on PlatformException catch (e) {
      eval = "Failed :(";
    }

    setState(() {
      incomingMessage = eval;
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
                          _message = message;
                        });
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'sendMessage',
                    ),
                    onPressed: () {
                      _sendMessage(_message);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

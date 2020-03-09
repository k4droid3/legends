import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String incomingMessage = "incoming Empty...";
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
              TextField(
                autocorrect: false,
                onSubmitted: (String message) {
                  setState(() {
                    outgoingMessage = message;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:legends/test.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

var messageByteStream = Stream.empty();
String gand;

void main() {
  runApp(MyApp());
}

void runxmpp() async {
  await xmppManager();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String incomingMessage = "incoming Empty...";
  String outgoingMessage = "outgoing Empty...";
//  String str;
//  final myController = TextEditingController();
//
//  textListener() {
//    setState(() {
//      str = myController.text;
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    myController.addListener(textListener(string));
//  }

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
                autofocus: false,
                autocorrect: false,
                onSubmitted: (String message) {
                  setState(() {
                    gand = message;
                    outgoingMessage = message;
                  });
                },
              ),
              RaisedButton(
                child: Text("try karke dekho"),
                onPressed: () {
                  messageByteStream = ByteStream.fromBytes(ascii.encode(gand))
                      .asBroadcastStream();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

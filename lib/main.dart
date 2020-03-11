import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_xmpp/flutter_xmpp.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String incomingMessage = "incoming Empty...";
  String outgoingMessage = "outgoing Empty...";

//  String name = "";
//  String message = "";
//  String id = "";
//  String reply = "";

  FlutterXmpp flutterXmpp;

  @override
  void initState() {
    super.initState();
    initXmpp();
  }

  @override
  void dispose() async {
    await flutterXmpp.stop();
    super.dispose();
  }

  Future<void> initXmpp() async {
    var auth = {
      "user_jid": "bot@legends.com",
      "password": "qwerty",
      "host": "172.25.163.196",
      "port": 5222
    };

    flutterXmpp = new FlutterXmpp(auth);
    print("AUTHENTICATED O_O");

    await flutterXmpp.login();

    await flutterXmpp.start(_onReceive, _onError);

    sleep(const Duration(seconds: 2));

    print(await flutterXmpp.currentState());
  }

  void _onReceive(dynamic event) {
    print(event);
    if (event["type"] == "incoming") {
      setState(() {
        incomingMessage = event['body'];
      });
    } else {
      setState(() {
        outgoingMessage = event['body'];
      });
    }
  }

  void _onError(Object error) {
    print(error);
  }

  void giveMessage(String message) async {
    await flutterXmpp.sendMessage("k4droid3@legends.com", message, "loda");
    setState(() {
      outgoingMessage = message;
    });
  }

  void giveGroupMessage(String message) async {
    await flutterXmpp.sendGroupMessage(
        "group@conference.legends.com", message, "lasson");
    setState(() {
      outgoingMessage = message;
    });
  }

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
                    giveMessage(message);
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

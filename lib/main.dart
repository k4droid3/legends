import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_xmpp/flutter_xmpp.dart';
import 'package:legends/Xmpp_handler.dart';
import 'package:legends/message_list.dart';

Stream<List<String>> stream;
BuildContext mainBuildContext;

void main() async {
  stream = Stream.value(messageDatabase).asBroadcastStream();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initXmpp();
    super.initState();
  }

  @override
  void dispose() {
    flutterXmpp.stop();
    super.dispose();
  }

//  bool onMessage(MyNotification notification) {
//    setState(() {
//      messageDatabase.add('ok');
//    });
//  }

  @override
  Widget build(BuildContext context) {
    mainBuildContext = context;
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Text> messageWidgets = [];
                    var messages = snapshot.data;
                    for (var message in messages) {
                      messageWidgets.add(Text(message.toString()));
                    }
                    return Column(
                      children: messageWidgets,
                    );
                  } else {
                    return Column(
                      children: <Widget>[],
                    );
                  }
                },
              ),
            ),
            TextField(
              onSubmitted: (String message) {
                setState(() {
                  messageDatabase.add(message);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_xmpp/flutter_xmpp.dart';
import 'package:legends/ip_handler.dart';
import 'package:legends/main.dart';
import 'package:legends/message_list.dart';

FlutterXmpp flutterXmpp;

Future<void> initXmpp() async {
//  String ip = await getIP();

  var auth = {
    "user_jid": "bot@legends.com",
    "password": "qwerty",
    "host": "172.25.172.209",
//    "host": ip,
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
//  MyNotification(title: "chitthi ayi hai").dispatch(mainBuildContext);
  if (event["type"] == "incoming") {
    messageDatabase.add(event['body']);
    databaseController.add(messageDatabase);
  }
  ;
//  } else {
//    setState(() {
//      outgoingMessage = event['body'];
//    });
//  }
}

void _onError(Object error) {
  print(error);
}

void giveMessage(String message) async {
  await flutterXmpp.sendMessage("k4droid3@legends.com", message, "loda");
  messageDatabase.add(message);
  databaseController.add(messageDatabase);
//  setState(() {
//    outgoingMessage = message;
//  });
}

//class MyNotification extends Notification {
//  final String title;
//
//  const MyNotification({this.title});
//}

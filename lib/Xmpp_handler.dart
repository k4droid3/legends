import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_xmpp/flutter_xmpp.dart';

FlutterXmpp flutterXmpp;

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
//  if (event["type"] == "incoming") {
//    setState(() {
//      incomingMessage = event['body'];
//    });
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
//  setState(() {
//    outgoingMessage = message;
//  });
}

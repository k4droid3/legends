import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_xmpp/flutter_xmpp.dart';
import 'package:legends/group_chat_screen.dart';
import 'package:legends/ip_handler.dart';
import 'package:legends/login_screen.dart';

FlutterXmpp flutterXmpp;

Future<void> initXmpp() async {
  final String ip = await getIP();
  var auth = {
    "user_jid": loggedInUser,
    "password": userPassword,
    "host": ip,
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
  MyMessage newMessage = MyMessage();
  if (event["type"] == "incoming") {
    newMessage.from = event['from'];
    newMessage.to = event['to'];
    newMessage.data = event['body'];
    messageDatabase.add(newMessage);
    databaseController.add(messageDatabase);
  }
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
  MyMessage newMessage = MyMessage();
  newMessage.from = loggedInUser;
  newMessage.to = "k4droid3@legends.com";
  newMessage.data = message;
  await flutterXmpp.sendMessage(newMessage.to, message, "loda");
  messageDatabase.add(newMessage);
  databaseController.add(messageDatabase);
//  setState(() {
//    outgoingMessage = message;
//  });
}

class MyMessage {
  String from, to, data;
}

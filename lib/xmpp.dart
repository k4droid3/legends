//import 'dart:convert';
//import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;
//import 'dart:io';
//import "package:console/console.dart";
//import 'package:http/http.dart';
//
//String userAtDomain = "bot@legends.com";
//String password = "qwerty";
//xmpp.Jid jid;
//xmpp.Jid receiver;
//xmpp.XmppAccount account;
//xmpp.Connection connection;
//xmpp.MessagesListener messagesListener;
//xmpp.MessageHandler messageHandler;
//
//void main() {
////  var username = "bot@legends.com";
////  var password = "qwerty";
////  var friend = "k4droid3@legends.com";
////
////  xmpp.Jid jid = xmpp.Jid.fromFullJid(username);
////  xmpp.Jid friend_jid = xmpp.Jid.fromFullJid(friend);
////
////  xmpp.XmppAccount account =
////      xmpp.XmppAccount(username, 'bot', 'legends.com', password, 5222);
////  xmpp.Connection connection = xmpp.Connection(account);
////  connection.open();
////
////  xmpp.MessageHandler messageHandler =
////      xmpp.MessageHandler.getInstance(connection);
////  xmpp.MessagesListener messagesListener = ExampleMessagesListener();
////  messageHandler.messagesStream.listen(messagesListener.onNewMessage);
////
////  messageHandler.sendMessage(friend_jid, "lode le ismein bhi chal ra hai");
////  while (true) {}
////}
////
////class ExampleMessagesListener implements xmpp.MessagesListener {
////  @override
////  onNewMessage(xmpp.MessageStanza message) {
////    if (message.body != null) {
////      print(format(
////          "New Message from {color.blue}${message.fromJid.userAtDomain}{color.end} message: {color.red}${message.body}{color.end}"));
////    }
////  }
//  jid = xmpp.Jid.fromFullJid(userAtDomain);
//  receiver = xmpp.Jid.fromFullJid("k4droid3@legends.com");
//  account =
//      xmpp.XmppAccount(userAtDomain, jid.local, jid.domain, password, 5222);
//  connection = xmpp.Connection(account);
//  connection.open();
//  messagesListener = ExampleMessagesListener();
//  LegendsConnnectionStateChangedListener(connection, messagesListener);
//}
//
//class LegendsConnnectionStateChangedListener
//    implements xmpp.ConnectionStateChangedListener {
//  xmpp.Connection _connection;
//  xmpp.MessagesListener _messagesListener;
//
//  LegendsConnnectionStateChangedListener(
//      xmpp.Connection connection, xmpp.MessagesListener messagesListener) {
//    _connection = connection;
//    _messagesListener = messagesListener;
//    _connection.connectionStateStream.listen(onConnectionStateChanged);
//  }
//
//  @override
//  void onConnectionStateChanged(xmpp.XmppConnectionState state) {
//    if (state == xmpp.XmppConnectionState.DoneServiceDiscovery) {
//      print("connected");
//
//      xmpp.MessageHandler messageHandler =
//          xmpp.MessageHandler.getInstance(_connection);
//      messageHandler.messagesStream.listen(_messagesListener.onNewMessage);
//    }
//    replyMessage("Gand mara", messageHandler);
//  }
//}
//
//void replyMessage(String message, xmpp.MessageHandler messageHandler) {
//  ByteStream.fromBytes(ascii.encode(message + " "))
//      .asBroadcastStream()
//      .map((bytes) {
//    var str = ascii.decode(bytes);
//    str = str.substring(0, str.length - 1);
//    return str;
//  }).listen((String str) {
//    messageHandler.sendMessage(receiver, str);
//  });
//}
//
//class ExampleMessagesListener implements xmpp.MessagesListener {
//  @override
//  onNewMessage(xmpp.MessageStanza message) {
//    if (message.body != null) {
//      print(format(
//          "New Message from {color.blue}${message.fromJid.userAtDomain}{color.end} message: {color.red}${message.body}{color.end}"));
//    }
//  }
//}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'dart:async';
import 'package:legends/Xmpp_handler.dart';
import 'package:legends/login_screen.dart';

StreamController<List<MyMessage>> databaseController =
    StreamController<List<MyMessage>>();
Stream<List<MyMessage>> stream;
BuildContext mainBuildContext;
List<MyMessage> messageDatabase = [];

class GroupChatScreen extends StatefulWidget {
  static const String id = "groupchatscreen";
  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController textEditingController;
  String mssg;

  @override
  void initState() {
    stream = databaseController.stream.asBroadcastStream();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.teal[500],
          centerTitle: true,
          title: Text(
            "Legends",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Transform.rotate(
              angle: 180 * pi / 180,
              child: Icon(Icons.exit_to_app),
            ),
            onPressed: () {
              flutterXmpp.stop();
              Navigator.pop(context);
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: MessagesStream(),
                ),
                SafeArea(
                  maintainBottomViewPadding: true,
                  bottom: true,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            enabled: true,
                            autofocus: true,
                            cursorColor: Colors.white,
                            onChanged: (String message) {
                              mssg = message;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Text ...",
                              hintStyle: TextStyle(
                                color: Colors.white54,
                              ),
                              filled: false,
                              fillColor: Colors.brown[500],
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                borderSide: BorderSide(
                                    color: Colors.brown,
                                    width: 0.0,
                                    style: BorderStyle.solid),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                borderSide: BorderSide(
                                    color: Colors.brown,
                                    width: 0.0,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        ClipOval(
                          child: Material(
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                            color: Colors.teal[500],
                            child: InkWell(
//                              radius: 5.0,
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(30.0)),
//                          padding: EdgeInsets.zero,
//                          shape: CircleBorder(),
//                          color: Colors.teal[500],
                              splashColor: Colors.brown,
                              child: SizedBox(
                                width: 49,
                                height: 49,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              onTap: () {
                                giveMessage(mssg);
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                textEditingController.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageBubble> messageBubbles = [];
          final messages = snapshot.data.reversed;
          for (var message in messages) {
            final messageText = message.data;
            final messageSender = message.from.split('@')[0];

            final currentUser = loggedInUser.split('@')[0];

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          );
        } else {
          return Column(
            children: <Widget>[],
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.white70,
                fontWeight: FontWeight.bold),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.brown : Colors.tealAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

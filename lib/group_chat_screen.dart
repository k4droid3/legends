import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:legends/Xmpp_handler.dart';

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SafeArea(
                  maintainBottomViewPadding: true,
                  bottom: true,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
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
                              filled: true,
                              fillColor: Colors.teal[500],
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                borderSide:
                                    BorderSide(color: Colors.teal, width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                                borderSide:
                                    BorderSide(color: Colors.teal, width: 0.0),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          child: FloatingActionButton(
                            backgroundColor: Colors.teal[500],
                            splashColor: Colors.brown,
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.0),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 25.0,
                              ),
                            ),
                            onPressed: () {
                              giveMessage(mssg);
                              FocusScope.of(context).requestFocus(FocusNode());
                              textEditingController.clear();
                            },
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

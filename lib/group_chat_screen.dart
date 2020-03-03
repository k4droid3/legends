import 'package:flutter/material.dart';

class GroupChatScreen extends StatefulWidget {
  static const String id = "groupchatscreen";
  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal[300],
        centerTitle: true,
        title: Text("Legends"),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: (){
            Navigator.pop(context);
          },
        ),       //What is this??
      ),
      backgroundColor: Colors.teal[300],
      body: Column(
        children: <Widget>[
          TextField(

          ),
        ],
      ),
    );
  }
}


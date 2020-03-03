import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'group_chat_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = "loginscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('images/anshul.jpg'),
                  radius: 50.0,
                  backgroundColor: Colors.tealAccent,
                ),
                Text(
                  "Anshul Sharma",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "SENIOR DEVELOPER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                    color: Colors.teal[100],
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.teal[700],
                  ),
                  padding: EdgeInsets.all(5.0),
                  
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 3),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding:EdgeInsets.only(left:8.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.teal[200],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.teal[700],
                  ),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.fromLTRB(30, 3, 30, 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.lock,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.teal[200],
                        ),
                      ),
                    ],
                  ),
                ),
                OutlineButton(
                  highlightElevation: 5.0,
                  highlightedBorderColor: Colors.brown[700],
                  color: Colors.brown,
                  textColor: Colors.white70,
                  borderSide: BorderSide(
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, GroupChatScreen.id);
                  },
                  child: Text(
                    "LogIn",
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}

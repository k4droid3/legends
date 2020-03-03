import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:legends/group_chat_screen.dart';
import 'package:legends/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        GroupChatScreen.id: (context) => GroupChatScreen(),
      },
    );
  }
//    return MaterialApp(
//      home: Container(
//        child: SafeArea(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Expanded(
//                child: RaisedButton(
//                  child: Center(
//                    child: Text("Click Me!"),
//                  ),
//                  onPressed: explore,
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var _file;

  void explore() async {
    _file = await FilePicker.getFile(type: FileType.ANY);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Center(
                    child: Text("Click Me!"),
                  ),
                  onPressed: explore,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

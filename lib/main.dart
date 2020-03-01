import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  void explore() async {
    var file = await FilePicker.getFile(type: FileType.ANY);
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

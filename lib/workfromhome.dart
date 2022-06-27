import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class wkfromhom extends StatefulWidget {
  const wkfromhom({Key? key}) : super(key: key);

  @override
  _wkfromhomState createState() => _wkfromhomState();
}

class _wkfromhomState extends State<wkfromhom> {
  var url = "https://omapp.omlogistics.co.in/work-from-home?empcode=" +
      universaladata.empcode.replaceAll(":", "").replaceAll(" ", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Work from Home',
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body:
          WebView(initialUrl: url, javascriptMode: JavascriptMode.unrestricted),
    );
  }
}

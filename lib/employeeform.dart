import 'dart:convert';
import 'package:employee_attendance/myattendance.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:employee_attendance/entryformdesign.dart';
import 'package:employee_attendance/exitformdesign.dart';
import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'leaveform.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: empservice(),
  ));
}

class empservice extends StatefulWidget {
  const empservice({Key? key}) : super(key: key);

  @override
  _empserviceState createState() => _empserviceState();
}

class _empserviceState extends State<empservice> {
  String latitudedata = "";
  String longitudedata = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentlocation();
    // Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  getCurrentlocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudedata = '${geoposition.latitude}';
      longitudedata = '${geoposition.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Emp Self Services"),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                fit: BoxFit.cover,
              )),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => entryform()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            child: Icon(
                              Icons.work_outlined,
                              size: 40,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20.0)),
                          Text(
                            "Office Entry Form",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: InkWell(
                        onTap: () {
                          _showdialog();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 80,
                                    child: Icon(
                                      Icons.outbond_sharp,
                                      size: 40,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 20.0)),
                                  Text(
                                    "Exit from Office",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ]),
                      )),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => leaveform()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 50,
                            child: Icon(
                              Icons.grading_outlined,
                              size: 40,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20.0)),
                          Text(
                            "Leave Form",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15.0),
                          ),
                          // Image.asset(
                          //   "images/leave.png",
                          //   height: 80,
                          //   width: 50,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => myattendance()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 50,
                            child: Icon(
                              Icons.receipt_long,
                              size: 40,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20.0)),
                          Text(
                            "My Attendance",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        ));
  }

  void _showdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text('Attendance Punch'),
        content: Text('Do you want to Punch Out'),
        actions: [
          ElevatedButton(
            child: const Text('Yes'),
            onPressed: () async {
              var headers = {'Content-Type': 'application/json'};
              var request = http.Request('POST',
                  Uri.parse('http://api.omlogistics.co.in/emp_visit.php'));
              request.body = json.encode({
                "empcode": universaladata.empcode,
                "bcode": universaladata.BCODE,
                "time": gettime().toString(),
                "lat": latitudedata,
                "long": longitudedata,
                "visit_type": "Attendance",
                "status": "visit_entry",
                "address": "",
                "reporting_to": "",
                "remarks": "",
                "destination": "",
                "from_date": "",
                "to_date": "",
                "source": ""
              });

              request.headers.addAll(headers);
              var response = await request.send();
              final respStr = await response.stream.bytesToString();
              Navigator.pop(context);
              var parsedJson = json.decode(respStr);
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'))
        ],
      ),
    );
  }

  gettime() {
    final String formattedDateTime =
        DateFormat('dd-MMM-yyyy : kk:mm:ss').format(DateTime.now()).toString();
    setState(() {
      print(formattedDateTime);
    });
  }
}

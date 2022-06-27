import 'dart:convert';
// import 'dart:html';
import 'package:employee_attendance/entryformdesign.dart';
import 'package:employee_attendance/exitformdesign.dart';
import 'package:employee_attendance/workfromhome.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:employee_attendance/universaldata.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'leaveform.dart';
import 'myattendance.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class officepage extends StatefulWidget {
  String latitudedata = "";
  String longitudedata = "";

  @override
  _officepageState createState() => _officepageState();
}

class _officepageState extends State<officepage> {
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
        title: Text('Employee Service'),
        backgroundColor: Colors.deepPurple,
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
              child: GridView.count(
                primary: true,
                shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                crossAxisSpacing: 7,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                children: [
                  Card(
                    margin: const EdgeInsets.all(15.0),
                    elevation: 6.0,
                    shadowColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const entryform()));
                      },
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "images/enquiry.png",
                              height: 65,
                              width: 60,
                            ),
                            const Text(
                              "Punch IN ",
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(15.0),
                    elevation: 6.0,
                    shadowColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        _showdialog();
                      },
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "images/exit.png",
                              height: 65,
                              width: 60,
                            ),
                            const Text(
                              "Punch OUT ",
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(15.0),
                    elevation: 6.0,
                    shadowColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => leaveform()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 50,
                            child: Icon(
                              Icons.grading_outlined,
                              size: 60,
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
                    margin: const EdgeInsets.all(15.0),
                    elevation: 6.0,
                    shadowColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => myattendance()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 50,
                            child: Icon(
                              Icons.receipt_long,
                              size: 60,
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
                  Card(
                    margin: const EdgeInsets.all(15.0),
                    elevation: 6.0,
                    shadowColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () async {
                        const url =
                            'https://omapp.omlogistics.co.in/work-from-home?empcode=33337';
                        if (await canLaunch(url)) launch(url);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            width: 45,
                            child: Icon(
                              Icons.receipt_long,
                              size: 60,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20.0)),
                          Text(
                            "WFH Report",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
        DateFormat('dd/MMM/yyyy : kk:mm:ss').format(DateTime.now()).toString();
    setState(() {
      print(formattedDateTime);
    });
  }

  // _launchURL() async {
  //   const url = 'https://omapp.omlogistics.co.in/work-from-home?empcode=' +
  //       universaladata.empcode;
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}

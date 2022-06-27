import 'dart:io';
import 'dart:ui';
import 'package:employee_attendance/DocumentManager/dashboard_dmanager.dart';
import 'package:employee_attendance/ENQUIRY.dart';
import 'package:employee_attendance/SalesCCD.dart';
import 'package:employee_attendance/VehicleModule/marketvehicle_hiring.dart';
import 'package:employee_attendance/employeeform.dart';
import 'package:employee_attendance/loginform.dart';
import 'package:employee_attendance/officeentrypage.dart';
import 'package:employee_attendance/universaldata.dart';
import 'package:employee_attendance/visitentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'networkdirectory/dashboard.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: dashboard(),
  ));
}

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  Widget imageslider = ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.black87,
      autoPlayInterval: 2000,
      isLoop: true,
      children: [
        Image.asset(
          'images/banner1.jpg',
          fit: BoxFit.fill,
        ),
        Image.asset(
          'images/banner2.png',
          fit: BoxFit.fill,
        ),
        Image.asset(
          'images/banner3.jpg',
          fit: BoxFit.fill,
        ),
      ]);

  //exit from app//
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  //*******//
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              universaladata.Name,
              style: const TextStyle(fontSize: 15.0),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                    // decoration: BoxDecoration(color: Colors.white),
                    child: Image.asset(
                  'images/profile.png',
                  alignment: Alignment.centerLeft,
                )),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                    size: 30.0,
                  ),
                  title: Text('My Profile'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.notifications_active,
                    color: Colors.purple,
                    size: 30.0,
                  ),
                  title: Text('Notification'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.share_rounded,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  title: Text('Share'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Image.asset(
                    'images/logout.png',
                    height: 55,
                    width: 30,
                  ),
                  title: Text('Sign out'),
                  onTap: () async {
                    SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => loginform()));
                  }
                )
              ],
            ),
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
                      Container(
                        height: 220,
                        child: imageslider,
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Colors.black38,
                      ),
                      GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 8,
                        crossAxisCount: 3,
                        children: [
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => officepage()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/freelancer.png",
                                      height: 65,
                                      width: 60,
                                    ),
                                    const Text(
                                      "Emp self service",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => enquirymodule()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/enquirycolor.png",
                                      height: 60,
                                      width: 60,
                                    ),
                                    const Text(
                                      "Enquiry",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => visitentry()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/visit.png",
                                      height: 65,
                                      width: 60,
                                    ),
                                    const Text(
                                      "Visit Entry",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => dmanagerdash()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/odmcolor.png",
                                      height: 65,
                                      width: 60,
                                    ),
                                    const Text(
                                      "Document Manager",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => naetworkdash()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/directorycolor.png",
                                      height: 65,
                                      width: 60,
                                    ),
                                    const Text(
                                      "Network Directory",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => officepage()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/operation.png",
                                      height: 75,
                                      width: 80,
                                    ),
                                    const Text(
                                      "Operation",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => officepage()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/vehicletracking.png",
                                      height: 75,
                                      width: 80,
                                    ),
                                    const Text(
                                      "Vehicle Tracking",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MarketVehicleHiring()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/truck.jpg",
                                      height: 75,
                                      width: 80,
                                    ),
                                    const Text(
                                      "Market Vehicle Hiring",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => officepage()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/barcode.png",
                                      height: 75,
                                      width: 80,
                                    ),
                                    const Text(
                                      "Barcode Module",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => officepage()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/geofencing.jpg",
                                      height: 75,
                                      width: 80,
                                    ),
                                    const Text(
                                      "Geo Fencing",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SALESCCD()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/report.jpg",
                                      height: 65,
                                      width: 60,
                                    ),
                                    const Text(
                                      "Sales/attendance report",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => officepage()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/misreport.png",
                                      height: 65,
                                      width: 60,
                                    ),
                                    const Text(
                                      "Customer MIS",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => officepage()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/radar.png",
                                      height: 75,
                                      width: 70,
                                    ),
                                    const Text(
                                      "Serviceble area",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => officepage()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/ng_logo.png",
                                      height: 65,
                                      width: 60,
                                    ),
                                    const Text(
                                      "Angular magic",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(0.0),
                            elevation: 8.0,
                            shadowColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: new BorderSide(
                                  color: Colors.brown, width: 1.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => officepage()));
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "images/approved.png",
                                        height: 65,
                                        width: 60,
                                      ),
                                      const Text(
                                        "Attendance Approved",
                                        style: TextStyle(fontSize: 14.0),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))),
            ],
          )),
    );
  }
}

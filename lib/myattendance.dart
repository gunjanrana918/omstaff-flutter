import 'dart:convert';
import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: myattendance(),
  ));
}

class myattendance extends StatefulWidget {
  const myattendance({Key? key}) : super(key: key);

  @override
  _myattendanceState createState() => _myattendanceState();
}

int rindex = 0;
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('dd-MMM-yyyy');
final month = DateFormat.MMMM().format(now);
final String year = now.year.toString();
final String day = now.day.toString();

class _myattendanceState extends State<myattendance> {
  final dateinputfrom = TextEditingController();
  final dateinputto = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final List<nodeattendance> _nodes = [];
  var arr = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  Future<List<nodeattendance>> getdata() async {
    var headers = {'Content-Type': 'application/json'};
    var req = http.Request(
        'POST', Uri.parse('http://api.omlogistics.co.in/leaveform.php'));
    req.body = json.encode({
      "status": "attendance",
      "emp": universaladata.empcode,
      "from_dt": "26" + "/" + arr[(DateTime.now().month - 1) - 1] + "/" + year,
      "to_dt": day + "/" + month + "/" + year,
    });
    req.headers.addAll(headers);
    http.StreamedResponse response = await req.send();
    final respStr = await response.stream.bytesToString();
    var parsedJson = json.decode(respStr);
    var nodesJson = parsedJson["detail"];

    // var nodesJson =
    //     List<Map<String, dynamic>>.from(json.decode(parsedJson["mis"]));
    print(nodesJson);
    List<nodeattendance> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      // ignore: non_constant_identifier_names
      String ATT_DATE = nodeJson["ATT_DATE"].toString();
      print(universaladata.lev_type);
      String DAY_NAME = nodeJson["DAY_NAME"].toString();
      String ATT_EMP_STATUS = nodeJson["ATT_EMP_STATUS"].toString();
      String ATT_STATUS = nodeJson["ATT_STATUS"].toString();

      nodes.add(new nodeattendance(
        ATT_DATE,
        DAY_NAME,
        ATT_EMP_STATUS,
        ATT_STATUS,
      ));
    }
    return nodes;
  }

  @override
  Widget build(BuildContext context) {
    getdata().then((value) {
      if (mounted == true) {
        setState(() {
          if (!_nodes.contains(value)) _nodes.addAll(value);
        });
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('My Attendance'),
          centerTitle: true,
          elevation: 5.0,
          backgroundColor: Colors.deepPurple,
        ),
        body: Stack(children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.dstATop),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: Row(children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: SizedBox(
                            height: 30,
                            child: TextField(
                              controller: dateinputfrom,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.calendar_today,
                                    size: 30.0,
                                  ),
                                  hintText: "From date",
                                  hintStyle: TextStyle(fontSize: 18.0)),
                              readOnly: true,
                              onTap: () {
                                _selectDate1();
                              },
                            )),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: dateinputto,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.calendar_today,
                                  size: 30.0,
                                ),
                                hintText: "To date",
                                hintStyle: TextStyle(fontSize: 18.0)),
                            readOnly: true,
                            onTap: () {
                              _selectDate();
                            },
                          )),
                    )
                  ]),
                ),
                Padding(padding: EdgeInsets.only(top: 4.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.0,
                      width: 180.0,
                      child: MaterialButton(
                          child: Text(
                            'Search',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          color: Colors.deepPurple,
                          onPressed: () {}),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: rindex,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 3.0,
                          // color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.grey)),
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 10.0, right: 15.0),
                            leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple[300]),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    _nodes[index].ATT_EMP_STATUS,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),

                            // Icon(
                            //   Icons.crop_square_sharp,
                            //   size: 25.0,
                            //   color: Colors.lightBlue,
                            // ),
                            title: Text(
                              _nodes[index].ATT_DATE +
                                  ' ' +
                                  ' ' +
                                  _nodes[index].DAY_NAME,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black),
                            ),
                            subtitle: Text(
                              universaladata.BCODE,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            trailing: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                primary: Colors.black,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              child: const Text('WFH Report'),
                              onPressed: () {},
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ]));
  }

  void _selectDate() {
    DateFormat formatter = DateFormat('dd/MMM/yyyy'); // use any formate
    String formatted = formatter.format(selectedDate);
    showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2100, 12),
        builder: (context, picker) {
          return Theme(
            //TODO: change colors
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.lightBlue,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: picker!,
          );
        }).then((selectedDate) {
      if (selectedDate != null) {
        dateinputto.value =
            TextEditingValue(text: formatter.format(selectedDate));
      }
    });
  }

  void _selectDate1() {
    DateFormat formatter = DateFormat('dd/MMM/yyyy'); // use any formate
    String formatted = formatter.format(selectedDate);
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2100, 12),
        builder: (context, picker) {
          return Theme(
            //TODO: change colors
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.lightBlue,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: picker!,
          );
        }).then((selectedDate) {
      if (selectedDate != null) {
        dateinputfrom.value =
            TextEditingValue(text: formatter.format(selectedDate));
        print('data');
        print(dateinputfrom.value);
        // selectedDate.toString().split(' ')[0];
      }
    });
  }
}

class nodeattendance {
  // late String BCODE;
  late String ATT_DATE;
  late String DAY_NAME;
  late String ATT_EMP_STATUS;
  late String ATT_STATUS;

  nodeattendance(
      this.ATT_DATE, this.DAY_NAME, this.ATT_EMP_STATUS, this.ATT_STATUS);

  nodeattendance.fromJson(String ATT_DATE, String DAY_NAME,
      String ATT_EMP_STATUS, String ATT_STATUS) {
    // this.BCODE = BCODE;
    this.ATT_DATE = ATT_DATE;
    this.DAY_NAME = DAY_NAME;
    this.ATT_EMP_STATUS = ATT_EMP_STATUS;
    this.ATT_STATUS = ATT_STATUS;
  }
}

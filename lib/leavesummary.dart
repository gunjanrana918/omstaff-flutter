// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: leavesummary(),
  ));
}

class leavesummary extends StatefulWidget {
  const leavesummary({Key? key}) : super(key: key);
  @override
  _leavesummaryState createState() => _leavesummaryState();
}

int rindex = 0;
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('dd-MMM-yyyy');
final month = DateFormat.MMMM().format(now);
final String year = now.year.toString();
final String day = now.day.toString();

class _leavesummaryState extends State<leavesummary> {
  // var nodesJson ;
  final dateinputfrom = TextEditingController();
  final dateinputto = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final List<nodeservice> _nodes = [];
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
var nodeJson;
  Future<List<nodeservice>> getdata() async {
    var headers = {'Content-Type': 'application/json'};
    var req = http.Request(
        'GET', Uri.parse('http://api.omlogistics.co.in/leaveform.php'));
    req.body = json.encode({
      "status": "mis",
      "emp": universaladata.user_id,
      "from_dt": "26" + "/" + arr[(DateTime.now().month - 1) - 1] + "/" + year,
      "to_dt": day + "/" + month + "/" + year,
    });
    req.headers.addAll(headers);
    http.StreamedResponse response = await req.send();
    final respStr = await response.stream.bytesToString();
    var parsedJson = json.decode(respStr);
    print(parsedJson);
     nodeJson = parsedJson["mis"];
    print('VALUE');
    print('response');
    print(nodeJson);
    List<nodeservice> nodes = [];
    rindex = 0;
    for (var nodeJson in nodeJson) {
      rindex++;
      // ignore: non_constant_identifier_names
      String LEV_TYPE = nodeJson["LEV_TYPE"].toString();
      // ignore: non_constant_identifier_names
      String LEV_STRT_DATE = nodeJson["LEV_STRT_DATE"].toString();
      // ignore: non_constant_identifier_names
      String LEV_END_DATE = nodeJson["LEV_END_DATE"].toString();
      // ignore: non_constant_identifier_names
      String LEV_REASON = nodeJson["LEV_REASON"].toString();
      // ignore: non_constant_identifier_names
      String REPORTING = nodeJson["REPORTING"].toString();
      nodes.add(nodeservice(
          LEV_TYPE, LEV_STRT_DATE, LEV_END_DATE, LEV_REASON, REPORTING));
    }
    return nodes;
  }

  @override
  Widget build(BuildContext context) {
    getdata().then((value) {
      if (mounted == true) {
        setState(() {
          // ignore: iterable_contains_unrelated_type
          if (! _nodes.contains(value)) _nodes.addAll(value);
        });
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leave Details'),
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
              child: Column(
                children: [
                  SizedBox(
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
                  const Padding(padding: EdgeInsets.only(top: 4.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.0,
                        width: 180.0,
                        child: MaterialButton(
                            child: const Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                            color: Colors.deepPurple,
                            onPressed: () async {
                              var headers = {'Content-Type': 'application/json'};
                                var req = http.Request(
                                    'GET', Uri.parse('http://api.omlogistics.co.in/leaveform.php'));
                                req.body = json.encode({
                                  "status": "mis",
                                  "emp": universaladata.user_id,
                                  "from_dt": dateinputfrom.text,
                                  "to_dt": dateinputto.text,
                                });
                                req.headers.addAll(headers);
                                http.StreamedResponse response = await req.send();
                                final resp = await response.stream.bytesToString();
                                var parsedata = json.decode(resp);
                              nodeJson.clear();
                                  nodeJson = parsedata["mis"];
                                print('NEWDATA');
                                print(nodeJson);
                              setState((){

                              });
                            }),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(1.0),
                        shrinkWrap: true,
                        itemCount: rindex,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.blue)),
                            margin: EdgeInsets.all(5),
                            shadowColor: Colors.grey,
                            child: Column(
                              children: [
                                Container(
                                  height: 35.0,
                                  child: Row(
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(left: 5.0)),
                                      Expanded(
                                          flex: 5,
                                          child: Container(
                                              child: Text(
                                            'Leave Type:' +
                                                " " + _nodes[index].LEV_TYPE,
                                            style: TextStyle(fontSize: 15.0),
                                          ))),
                                     const Padding(
                                          padding: EdgeInsets.only(left: 5.0)),
                                      Expanded(
                                          flex: 6,
                                          child: Container(
                                              child: Text(
                                            'Reporting Person:' +
                                                " " +
                                                _nodes[index].REPORTING,
                                            style: TextStyle(fontSize: 15.0),
                                          )))
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1.0,
                                ),
                                Container(
                                  height: 30.0,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 5.0)),
                                      Expanded(
                                          flex: 5,
                                          child: Container(
                                              child: Text('From:' +
                                                  " " +
                                                  _nodes[index].LEV_STRT_DATE))),
                                      Expanded(
                                          flex: 5,
                                          child: Container(
                                              child: Text('To:' +
                                                  " " +
                                                  _nodes[index].LEV_END_DATE)))
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30.0,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 5.0)),
                                      Expanded(
                                          flex: 5,
                                          child: Container(
                                              child: Text('Reason:' +
                                                  '' +
                                                  '' +
                                                  _nodes[index].LEV_REASON))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ));
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
        // selectedDate.toString().split(' ')[0];
      }
    });
  }
}

class nodeservice {
  late String LEV_TYPE;
  late String LEV_STRT_DATE;
  late String LEV_END_DATE;
  late String LEV_REASON;
  late String REPORTING;

  nodeservice(this.LEV_TYPE, this.LEV_STRT_DATE, this.LEV_END_DATE,
      this.LEV_REASON, this.REPORTING);

  nodeservice.fromJson(String EMP_FIRST_NAME, String DEPT_NAME,
      String DESIG_NAME, String LEV_REASON, String REPORTING) {
    this.LEV_TYPE = EMP_FIRST_NAME;
    this.LEV_STRT_DATE = DEPT_NAME;
    this.LEV_END_DATE = DESIG_NAME;
    this.LEV_REASON = LEV_REASON;
    this.REPORTING = REPORTING;
  }
}

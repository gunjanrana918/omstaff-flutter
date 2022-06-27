import 'dart:convert';

import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: misleave(),
  ));
}

class misleave extends StatefulWidget {
  const misleave({Key? key}) : super(key: key);

  @override
  State<misleave> createState() => _misleaveState();
}

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

int rindex = 0;
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('dd-MMM-yyyy');
final month = DateFormat.MMMM().format(now);
final String year = now.year.toString();
final String day = now.day.toString();

class _misleaveState extends State<misleave> {
  List<nodeservice> _nodes = [];

  Map<String, String>? get headers => null;
  Future<List<nodeservice>> getdata() async {
    // var headers = {'Content-Type': 'application/json'};
    var req = http.Request(
        'POST', Uri.parse('http://api.omlogistics.co.in/leaveform.php'));
    req.body = json.encode({
      "status": "mis",
      "emp": universaladata.empcode,
      "from_dt": "26" + "/" + arr[(DateTime.now().month - 1) - 1] + "/" + year,
      "to_dt": day + "/" + month + "/" + year,
    });
    print(req);
    req.headers.addAll(headers!);
    http.StreamedResponse response = await req.send();
    final respStr = await response.stream.bytesToString();
    var parsedJson = json.decode(respStr);
    print('DATA');
    print(parsedJson);
    // var nodesJson = List<Map<String, dynamic>>.from((parsedJson));
    // print(nodesJson);
    List<nodeservice> nodes = [];
    rindex = 0;
    for (var nodeJson in parsedJson) {
      rindex++;
      // ignore: non_constant_identifier_names
      String LEV_TYPE = nodeJson["LEV_TYPE"].toString();
      String LEV_STRT_DATE = nodeJson["LEV_STRT_DATE"].toString();
      String LEV_END_DATE = nodeJson["LEV_END_DATE"].toString();
      String LEV_REASON = nodeJson["LEV_REASON"].toString();
      String REPORTING = nodeJson["REPORTING"].toString();

      nodes.add(new nodeservice(
          LEV_TYPE, LEV_STRT_DATE, LEV_END_DATE, LEV_REASON, REPORTING));
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
        title: Text('Leave'),
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
                ListView.builder(
                    padding: EdgeInsets.all(7.0),
                    shrinkWrap: true,
                    itemCount: rindex,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white54)),
                        margin: EdgeInsets.all(2),
                        shadowColor: Colors.grey,
                        child: Column(
                          children: [
                            Container(
                              height: 30.0,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                          child: Text('Leave Type:' +
                                              universaladata.lev_type))),
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                          child: Text('Reporting Person:' +
                                              universaladata.reporting_pr)))
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
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                          child: Text('From:' +
                                              universaladata.start_date))),
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                          child: Text(
                                              'To:' + universaladata.end_date)))
                                ],
                              ),
                            ),
                            Container(
                              height: 30.0,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                          child: Text('Reason:' +
                                              universaladata.lev_reason))),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
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

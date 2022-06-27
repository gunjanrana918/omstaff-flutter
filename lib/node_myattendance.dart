import 'dart:convert';

import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class myattend extends StatefulWidget {
  const myattend({Key? key}) : super(key: key);

  @override
  State<myattend> createState() => _myattendState();
}

int rindex = 0;

class _myattendState extends State<myattend> {
  List<nodeservice> _nodes = [];

  Future<List<nodeservice>> getdata() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MMM-yyyy');
    final month = DateFormat.MMMM().format(now);
    final String year = now.year.toString();
    final String day = now.day.toString();
    var headers = {'Content-Type': 'application/json'};
    var req = http.Request(
        'POST', Uri.parse('http://api.omlogistics.co.in/leaveform.php'));
    req.body = json.encode({
      "status": "attendance",
      "emp": universaladata.empcode,
      "from_dt": "25/" + month + "/" + year,
      "to_dt": day + "/" + month + "/" + year,
    });

    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    // print(nodeJson);
    List<nodeservice> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
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
    return Container();
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

import 'dart:async';
import 'dart:convert';
import 'package:employee_attendance/node_reporting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:employee_attendance/universaldata.dart';

void main() {
  runApp(MaterialApp(
    home: newreport(),
  ));
}

class newreport extends StatefulWidget {
  const newreport({Key? key}) : super(key: key);

  @override
  _newreportState createState() => _newreportState();
}

int rindex = 0;

class _newreportState extends State<newreport> {
  final scontroller = new TextEditingController();
  bool isMount = true;
  List<Nodereport> _nodes = [];

  Future<List<Nodereport>> getdata() async {
    var req = await http.get(Uri.parse('http://omsanchar.omlogistics.co.'
        'in/oracle/android_api/emp_networkdir.php'));

    var nodesJson =
        List<Map<String, dynamic>>.from(json.decode(req.body)['emp_enquiry']);
    List<Nodereport> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      // ignore: non_constant_identifier_names
      String EMP_FIRST_NAME = nodeJson["EMP_FIRST_NAME"].toString();
      String DEPT_NAME = nodeJson["DEPT_NAME"].toString();
      String DESIG_NAME = nodeJson["DESIG_NAME"].toString();
      String BRANCH_NAME = nodeJson["BRANCH_NAME"].toString();
      var jar = {
        "EMP_FIRST_NAME": EMP_FIRST_NAME,
        "DEPT_NAME": DEPT_NAME,
        "DESIG_NAME": DESIG_NAME,
        "BRANCH_NAME": BRANCH_NAME
      };
      _allUsers.add(jar);
    }
    return nodes;
  }

  ////*****////
  final List<Map<String, dynamic>> _allUsers = [];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user["EMP_FIRST_NAME"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
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
        title: Text('Reporting Person'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: scontroller,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  _runFilter(value);
                  // _showdialog();
                },
              )),
          Expanded(
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(5.0),
                        // color: Colors.white54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            _showdialog();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _foundUsers[index]["EMP_FIRST_NAME"],
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _foundUsers[index]["DEPT_NAME"],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  _foundUsers[index]["DESIG_NAME"],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  _foundUsers[index]["BRANCH_NAME"],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 20),
                  ),
          )
        ],
      ),
    );
  }

  void _showdialog() {
    TextEditingController scontroller = new TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reporting Person'),
        content: Text(
          'You have selected' +
              universaladata.reporting_pr +
              'as an reporting persaon. '
                  'Do you want to continue',
          softWrap: true,
          style: TextStyle(fontSize: 13.0),
        ),
        actions: [
          ElevatedButton(
              child: const Text('Continue'),
              onPressed: () async {
                var headers = {'Content-Type': 'application/json'};
                var request = http.Request('POST',
                    Uri.parse('http://api.omlogistics.co.in/leaveform.php'));
                request.body = json.encode({
                  "status": "entry",
                  "emp": universaladata.empcode,
                  "bcode": universaladata.BCODE,
                  "lev_type": universaladata.lev_type,
                  "start_date": universaladata.start_date,
                  "end_date": universaladata.end_date,
                  "days": universaladata.days,
                  "lev_reason": universaladata.lev_reason,
                  "reporting_pr": scontroller.text,
                  "in_time": "",
                  "out_time": " ",
                });
                scontroller.text = universaladata.reporting_pr;
                request.headers.addAll(headers);
                http.StreamedResponse response = await request.send();
                final respStr = await response.stream.bytesToString();
                var parsedJson = json.decode(respStr);
                // print(parsedJson);
                if (parsedJson['error'] == 'false') {
                  Fluttertoast.showToast(
                      msg: 'Your Application Submitted Successfully',
                      gravity: ToastGravity.CENTER,
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.white,
                      textColor: Colors.blue,
                      fontSize: 18.0);
                }
                Navigator.of(context).pop(true);
              }),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'))
        ],
      ),
    );
  }
}

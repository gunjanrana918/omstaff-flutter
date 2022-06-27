import 'dart:convert';

import 'package:flutter/material.dart';

import 'leavesummary.dart';
import 'node_reporting.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMount = true;
  List<Nodereport> _nodes = [];
  Future<List<Nodereport>> getdata() async {
    var req = await http.get(Uri.parse('http://omsanchar.omlogistics.co.'
        'in/oracle/android_api/emp_networkdir.php'));

    var nodesJson =
        List<Map<String, dynamic>>.from(json.decode(req.body)['emp_enquiry']);
    print('DATA');
    print(nodesJson);
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

  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
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
        title: const Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["EMP_FIRST_NAME"]),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                            leading: Text(
                              _foundUsers[index]["EMP_FIRST_NAME"].toString(),
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(_foundUsers[index]['DEPT_NAME']),
                            subtitle: Text(
                                _foundUsers[index]["DESIGN_NAME"].toString())),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: iterable_contains_unrelated_type, camel_case_types, non_constant_identifier_names, prefer_initializing_formals, deprecated_member_use

import 'dart:convert';
import 'package:employee_attendance/universaldata.dart';
import 'package:http/http.dart'as http;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class staff_list extends StatefulWidget {
  const staff_list({Key? key}) : super(key: key);

  @override
  State<staff_list> createState() => _staff_listState();
}

int rindex = 0;
class _staff_listState extends State<staff_list> {
  final textEditingController = TextEditingController();
  final searchcontroller = TextEditingController();
  //****fetch staff details**///
  final List<nodestaff> _nodes = [];
  Future<List<nodestaff>> getdata() async {
    var req = await http.get(Uri.parse('http://api.omlogistics.co.in/emp_networkdir.php'));

    var nodesJson =
    List<Map<String, dynamic>>.from(json.decode(req.body)['emp_enquiry']);
    List<nodestaff> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String EMP_FIRST_NAME = nodeJson["EMP_FIRST_NAME"].toString();
      String BRANCH_NAME = nodeJson["BRANCH_NAME"].toString();
      String DEPT_NAME = nodeJson["DEPT_NAME"].toString();
      String EMP_LANDLINE_NO = nodeJson["EMP_LANDLINE_NO"].toString();
      String EMP_PHONE_NO = nodeJson["EMP_PHONE_NO"].toString();
      String EMP_PER_PHONE_NO = nodeJson["EMP_PER_PHONE_NO"].toString();
      String EMP_EMAIL_ID = nodeJson["EMP_EMAIL_ID"].toString();
      var jar = {
        "EMP_FIRST_NAME": EMP_FIRST_NAME,
        "BRANCH_NAME": BRANCH_NAME,
        "DEPT_NAME": DEPT_NAME,
        "EMP_LANDLINE_NO": EMP_LANDLINE_NO,
        "EMP_PHONE_NO": EMP_PHONE_NO,
        "EMP_PER_PHONE_NO": EMP_PER_PHONE_NO,
        "EMP_EMAIL_ID": EMP_EMAIL_ID
      };
      _stafflist.add(jar);
    }
    return nodes;
  }
  final List<Map<String, dynamic>> _stafflist = [];
  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _stafflist;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _stafflist;
    } else {
      results = _stafflist
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
        title: const Text('Staff'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
             color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.redAccent.withOpacity(0.1),
                  Colors.blue,
                ],
                stops: const [
                  0.0,
                  1.0,
                ]
              )
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: searchcontroller,
                  decoration: const InputDecoration(

                    hintText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value){
                    _runFilter(value);
                  },
                ),),
              Padding(padding: EdgeInsets.only(top: 5.0)),
              Expanded(
                child:_foundUsers.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) {
                    return
                      Card(
                      margin: const EdgeInsets.all(10.0),
                      // color: Colors.white54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.brown, width: 1.0),
                      ),
                      child: InkWell(
                        onTap: () {

                           _launchPhoneURL(universaladata.EMP_PHONE_NO);
                          // _showdialog();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                         children: [
                           Expanded(
                               child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             mainAxisSize: MainAxisSize.min,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 _foundUsers[index]["EMP_FIRST_NAME"],
                                 style: const TextStyle(
                                   fontSize: 15.0,
                                 ),
                               ),
                               Text(
                                 _foundUsers[index]["DEPT_NAME"],
                                 style: const TextStyle(
                                   fontSize: 15.0,
                                 ),
                               ),
                               Text(
                                 _foundUsers[index]["BRANCH_NAME"],
                                 style: const TextStyle(
                                     fontSize: 16.0,
                                     fontWeight: FontWeight.bold),
                               ),
                             ],
                           )
                           ),
                           Expanded(child:
                           Column(
                             mainAxisAlignment: MainAxisAlignment.end,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               IconButton(
                               icon: Icon(Icons.call,size: 25.0,color: Colors.blue,),
                                   onPressed: (){
                                     _launchPhoneURL(textEditingController.text);
                                   },
                                   ),
                               IconButton(
                                 icon: Icon(Icons.mail,size: 25.0,color: Colors.deepPurple,),
                                 onPressed: (){
                                   _sendingmail(universaladata.EMP_EMAIL_ID);
                                   },
                               ),
                               // IconButton(
                               //   icon: Icon(Icons.add_ic_call_outlined,size: 25.0,color: Colors.deepPurple,),
                               //   onPressed: (){
                               //     _calllandline(universaladata.EMP_LANDLINE_NO);
                               //     },)
                             ],
                           ))
                         ]

                          ),

                        ),
                      ),
                    );
                  },
                )
                    : const Center(
    child: CircularProgressIndicator()),
              )
            ],
          )
        ],
      ),

    );
  }
  _launchPhoneURL(String EMP_PHONE_NO) async {
    String url = 'tel:' + EMP_PHONE_NO;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _sendingmail(String EMP_EMAIL_ID) async {
    String url =  'email: ' + EMP_EMAIL_ID;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // _calllandline(String EMP_LANDLINE_NO) async {
  //   String url =  'email: ' + EMP_LANDLINE_NO;
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

}
class nodestaff {
  late String BRANCH_NAME;
  late String EMP_FIRST_NAME;
  late String DEPT_NAME;
  late String EMP_LANDLINE_NO;
  late String EMP_PHONE_NO;
  late String EMP_PER_PHONE_NO;
  late String EMP_EMAIL_ID;

  late String branchp_email;

    nodestaff( this.BRANCH_NAME, this.DEPT_NAME,
        this.EMP_FIRST_NAME, this.EMP_LANDLINE_NO, this.EMP_PHONE_NO, this.EMP_PER_PHONE_NO, this.EMP_EMAIL_ID);

  nodestaff.fromJson(
       String BRANCH_NAME, String EMP_FIRST_NAME,
      String DEPT_NAME, String EMP_LANDLINE_NO, String EMP_PHONE_NO, String EMP_PER_PHONE_NO, String EMP_EMAIL_ID)
  {

    this.BRANCH_NAME = BRANCH_NAME;
    this.EMP_FIRST_NAME = EMP_FIRST_NAME;
    this.DEPT_NAME = DEPT_NAME;
    this.EMP_LANDLINE_NO = EMP_LANDLINE_NO;
    this.EMP_PHONE_NO = EMP_PHONE_NO;
    this.EMP_PER_PHONE_NO = EMP_PER_PHONE_NO;
    this.EMP_EMAIL_ID =  EMP_EMAIL_ID;
  }
}

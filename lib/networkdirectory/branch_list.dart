// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';

void maim(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}
int rindex = 0;
class branchlist extends StatefulWidget {
  const branchlist({Key? key}) : super(key: key);

  @override
  State<branchlist> createState() => _branchlistState();
}
final List<branchstaff> _nodes = [];
class _branchlistState extends State<branchlist> {
  late TextEditingController dialpadcontroller = TextEditingController();
  late  TextEditingController searchcontroller = TextEditingController();
  Future<List<branchstaff>> getdata() async {
    var req = await http.get(Uri.parse('http://api.omlogistics.co.in/branch_networkdir.php'));
    var nodesJson =
    List<Map<String, dynamic>>.from(json.decode(req.body)['emp_enquiry']);
    List<branchstaff> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String BRANCH_BRANCH_CODE = nodeJson["BRANCH_BRANCH_CODE"].toString();
      //universaladata.BRANCH_BRANCH_CODE = BRANCH_BRANCH_CODE;
      String BRANCH_BRANCH_NAME = nodeJson["BRANCH_BRANCH_NAME"].toString();
      //universaladata.BRANCH_NAME = BRANCH_NAME;
      String CITY_CITY_NAME = nodeJson["CITY_CITY_NAME"].toString();
      //universaladata.DEPT_NAME = DEPT_NAME;
      String BRANCH_CONTACT_PERSON = nodeJson["BRANCH_CONTACT_PERSON"].toString();
      //universaladata.EMP_LANDLINE_NO = EMP_LANDLINE_NO;
      String BRANCH_CONTACT_NO = nodeJson["BRANCH_CONTACT_NO"].toString();
      //universaladata.EMP_PHONE_NO = EMP_PHONE_NO;
      String BRANCH_MOBILET_NO = nodeJson["BRANCH_MOBILET_NO"].toString();
      //universaladata.BRANCH_MOBILET_NO = BRANCH_MOBILET_NO;
      String BRANCH_EMAIL_ID = nodeJson["BRANCH_EMAIL_ID"].toString();
      //universaladata.BRANCH_EMAIL_ID = BRANCH_EMAIL_ID;
      var jar = {
        "BRANCH_BRANCH_CODE": BRANCH_BRANCH_CODE,
        "BRANCH_BRANCH_NAME": BRANCH_BRANCH_NAME,
        "CITY_CITY_NAME": CITY_CITY_NAME,
        "BRANCH_CONTACT_PERSON": BRANCH_CONTACT_PERSON,
        "BRANCH_CONTACT_NO": BRANCH_CONTACT_NO,
        "BRANCH_MOBILET_NO": BRANCH_MOBILET_NO,
        "BRANCH_EMAIL_ID": BRANCH_EMAIL_ID
      };
      _branchlist.add(jar);
    }
    return nodes;
  }
  final List<Map<String, dynamic>> _branchlist = [];
  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _branchlist;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _branchlist;
    } else {
      results = _branchlist
          .where((user) => user["BRANCH_CONTACT_PERSON"]
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
        title: Text('Branch Contact'),
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
                            // print("Data"+ universaladata.EMP_PHONE_NO);
                            // _launchPhoneURL(universaladata.EMP_PHONE_NO);
                            // // _showdialog();
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
                                            _foundUsers[index]["BRANCH_BRANCH_NAME"] +" "+ (_foundUsers[index]["BRANCH_BRANCH_CODE"]),
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            _foundUsers[index]["CITY_CITY_NAME"],
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            _foundUsers[index]["BRANCH_CONTACT_PERSON"],
                                            style: const TextStyle(
                                                fontSize: 16.0,),
                                          ),
                                          Text(
                                            _foundUsers[index]["BRANCH_CONTACT_NO"],
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                               ),
                                          ),
                                        ],
                                      )
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.call,size: 25.0,color: Colors.blue,),
                                        onPressed: (){
                                          _launchPhoneURL(dialpadcontroller.text);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_location,size: 25.0,color: Colors.deepPurple,),
                                        onPressed: (){
                                          // _calllandline(universaladata.EMP_LANDLINE_NO);
                                        },)],
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
  _launchPhoneURL(String BRANCH_MOBILET_NO) async {
    String url = 'tel:' + BRANCH_MOBILET_NO;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> dialNumber(
      {required String BRANCH_MOBILET_NO, required BuildContext context}) async {
    final url = "tel:$BRANCH_MOBILET_NO";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // showSnackBar(context, "Unable to call $phoneNumber");
    }

    return;
  }
}
class branchstaff {
  late String BRANCH_BRANCH_CODE;
  late String BRANCH_BRANCH_NAME;
  late String CITY_CITY_NAME;
  late String BRANCH_CONTACT_PERSON;
  late String BRANCH_CONTACT_NO;
  late String BRANCH_MOBILET_NO;
  late String BRANCH_EMAIL_ID;



  branchstaff( this.BRANCH_BRANCH_CODE, this.BRANCH_BRANCH_NAME,
      this.CITY_CITY_NAME, this.BRANCH_CONTACT_PERSON, this.BRANCH_CONTACT_NO, this.BRANCH_MOBILET_NO, this.BRANCH_EMAIL_ID);

  branchstaff.fromJson(
      String BRANCH_BRANCH_CODE, String BRANCH_BRANCH_NAME,
      String CITY_CITY_NAME, String BRANCH_CONTACT_PERSON, String BRANCH_CONTACT_NO, String BRANCH_MOBILET_NO, String BRANCH_EMAIL_ID)
  {

    this.BRANCH_BRANCH_CODE = BRANCH_BRANCH_CODE;
    this.BRANCH_BRANCH_NAME = BRANCH_BRANCH_NAME;
    this.CITY_CITY_NAME = CITY_CITY_NAME;
    this.BRANCH_CONTACT_PERSON = BRANCH_CONTACT_PERSON;
    this.BRANCH_CONTACT_NO = BRANCH_CONTACT_NO;
    this.BRANCH_MOBILET_NO = BRANCH_MOBILET_NO;
    this.BRANCH_EMAIL_ID =  BRANCH_MOBILET_NO;
  }
}

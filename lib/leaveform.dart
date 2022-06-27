import 'dart:convert';
import 'dart:ui';
import 'package:employee_attendance/leavesummary.dart';
import 'package:employee_attendance/new_report.dart';
import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}




class leaveform extends StatefulWidget {
  const leaveform({Key? key}) : super(key: key);

  @override
  _leaveformState createState() => _leaveformState();
}

int rindex = 0;

class _leaveformState extends State<leaveform> {




  bool isMount = true;
  List<nodeservice> _nodes = [];
  late SharedPreferences? logindata = null;
  final dayscontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final reasoncontroller = TextEditingController();
  final dateinputfrom = TextEditingController();
  final dateinputto = TextEditingController();
  TextEditingController controller = new TextEditingController();
  var dropdownleavetype;
  late String dropdown;
  DateTime selectedDate = DateTime.now();
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

  @override
  Widget build(BuildContext context) {

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MMM-yyyy');
    final month = DateFormat.MMMM().format(now);
    final String year = now.year.toString();
    final String day = now.day.toString();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Leave Form',
            style: TextStyle(fontSize: 14.0),
          ),
          elevation: 5.0,
          backgroundColor: Colors.deepPurple,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const leavesummary()));
              },
              child: const Text(
                'Leave Sum',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: (EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: universaladata.Name,
                           hintText: universaladata.user_id,
                          labelStyle:
                              TextStyle(fontSize: 20.0, color: Colors.black54),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      TextField(
                        controller: dayscontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: "No. of days",
                          labelStyle: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                          hintText: "Enter the day ",
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Container(
                        height: 100,
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.0),
                              child: SizedBox(
                                  height: 30,
                                  child: TextField(
                                    keyboardType: TextInputType.datetime,
                                    controller: dateinputfrom,
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent),
                                        ),
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
                                  keyboardType: TextInputType.datetime,
                                  controller: dateinputto,
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent),
                                      ),
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
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      TextField(
                        controller: reasoncontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          labelText: "Reason",
                          labelStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                          hintText: " reason",
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                          ),
                          // fillColor: Colors.grey[200],
                          //   filled: true,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 60,
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            itemHeight: 50.0,
                            padding: const EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                                color: Colors.blueAccent, width: 1),
                            dropdownButtonColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down_circle),
                            hint: const Text(
                              "Leave Type",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            value: dropdownleavetype,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownleavetype = newValue;
                              });
                            },
                            items: [
                              'Leave',
                              'My leave',
                              'Short leave',
                              'Half day',
                              'Extra duty',
                              'Componsatory leave',
                            ]
                                .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      MaterialButton(
                        color: Colors.deepPurpleAccent,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          if (dayscontroller.text != '' &&
                              dateinputfrom.text != '' &&
                              dateinputto.text != '' &&
                              reasoncontroller.text != '' &&
                              dropdownleavetype.toString() != '') {
                            universaladata.lev_type = dropdownleavetype;
                            universaladata.start_date = dateinputfrom.text;
                            universaladata.end_date = dateinputto.text;
                            universaladata.days = dayscontroller.text;
                            universaladata.lev_reason = reasoncontroller.text;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => newreport()));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please fill all fields.",
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_LONG,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.red,
                                textColor: Colors.blue,
                                fontSize: 15.0);
                          }
                        },
                      )
                    ],
                  ),
                ),
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
        print('data');
        print(dateinputfrom.value);
        // selectedDate.toString().split(' ')[0];
      }
    });
  }
}

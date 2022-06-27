import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

import 'new_report.dart';

void main() {
  runApp(MaterialApp());
}

class empvisitentry extends StatefulWidget {
  const empvisitentry({Key? key}) : super(key: key);

  @override
  State<empvisitentry> createState() => _empvisitentryState();
}

class _empvisitentryState extends State<empvisitentry> {
  final empcodecontroller = TextEditingController();
  final chatcontroller = TextEditingController();
  var dropdownlocation;
  var dropdownsourcelocation;
  var dropdowndestlocation;
  var timedropdown;
  late String dropdown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              color: Colors.blueGrey[300],
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                    TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueAccent, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: universaladata.empcode,
                      // hintText: universaladata.empcode,
                      labelStyle:
                      TextStyle(fontSize: 20.0, color: Colors.black54),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 60,
                        child: DropdownButtonHideUnderline(
                          child:
                          GFDropdown(
                            itemHeight: 50.0,
                            padding: const EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                                color: Colors.blueAccent, width: 1),
                            dropdownButtonColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down_circle),
                            hint: const Text(
                              "Visit Type",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            value: dropdownlocation,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownlocation = newValue;
                              });
                            },
                            items: [
                              'Branch',
                              'Client',
                              'Training',
                              'Seminar',
                            ]
                                .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                                .toList(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(padding: EdgeInsets.only(left: 2.0),
                                child:GFDropdown(
                                    itemHeight: 50.0,
                                    padding: const EdgeInsets.all(15),
                                    borderRadius: BorderRadius.circular(5),
                                    border: const BorderSide(
                                        color: Colors.blueAccent, width: 1),
                                    dropdownButtonColor: Colors.white,
                                    // icon: const Icon(Icons.location_searching_rounded),
                                    hint: const Text(
                                      "Source",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    value: dropdownsourcelocation,
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownsourcelocation = newValue;
                                      });
                                    },
                                    items: [
                                      'Home',
                                      'Branch',
                                      'Hotel',
                                    ]
                                        .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                        .toList(),
                                  ),
                                ),
                                ),

                            Expanded(
                              child: Padding(padding: EdgeInsets.only(left: 2.0),
                                child: GFDropdown(
                                    itemHeight: 50.0,
                                    padding: const EdgeInsets.all(15),
                                    borderRadius: BorderRadius.circular(5),
                                    border: const BorderSide(
                                        color: Colors.blueAccent, width: 1),
                                    dropdownButtonColor: Colors.white,
                                    // icon: const Icon(Icons.add_location_rounded),
                                    hint: const Text(
                                      "Destination",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    value: dropdowndestlocation,
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdowndestlocation = newValue;
                                      });
                                    },
                                    items: [
                                      'Home',
                                      'Branch',
                                      'Hotel',
                                    ]
                                        .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                        .toList(),
                                  ),
                                ),
                              ),])),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.0),
                              child: SizedBox(
                                  height: 40,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent),
                                        ),
                                        icon: Icon(
                                          Icons.calendar_today,
                                          size: 30.0,
                                        ),
                                        // fillColor: Colors.white,
                                        // filled: true,
                                        hintText: "From date",
                                        hintStyle: TextStyle(fontSize: 18.0)),
                                    readOnly: true,
                                    onTap: () {},
                                  )),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                                height: 30,
                                child: TextField(
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
                                  },
                                )),
                          )
                        ]),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5),
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            padding: const EdgeInsets.all(10),
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                              color: Colors.black12,
                              width: 2,
                            ),
                            dropdownButtonColor: Colors.white,
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.blueAccent,
                              size: 35,
                            ),
                            hint: Text(
                              "Select Time",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            value: timedropdown,
                            onChanged: (newValue) {
                              setState(() {
                                timedropdown = newValue;
                              });
                            },
                            items: [
                              'Visit First Half',
                              'Visit Second Half',
                              'Visit Full Day'
                            ]
                                .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                                .toList(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(5),
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.chat,
                                  color: Colors.blueAccent,
                                  size: 35,
                                ),
                                hintText: "Remarks"),
                            controller: chatcontroller,
                          )),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      MaterialButton(
                        elevation: 8,
                        color: Colors.deepPurpleAccent,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () async {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => newreport()));
                          } ,
                      )

                    ],
                  ),
                ),)
        )
          ]
        )
    );
  }
}

import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: exitform(),
  ));
}

class exitform extends StatefulWidget {
  const exitform({Key? key}) : super(key: key);

  @override
  _exitformState createState() => _exitformState();
}

class _exitformState extends State<exitform> {
  get dropdownValue => null;
  final empnamecontroller = TextEditingController();
  final timecontroller = TextEditingController();
  final chatcontroller = TextEditingController();
  final datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Attendance punch",
            style: TextStyle(fontSize: 15.0),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                        size: 35,
                      ),
                      hintText: universaladata.empcode),
                  readOnly: true,
                  controller: empnamecontroller,
                )),
            //****date selector***//
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Padding(padding: EdgeInsets.only(right: 80)),
                SizedBox(
                  width: 180,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                      Icons.date_range,
                      color: Colors.blueAccent,
                      size: 30,
                    )),
                    controller: timecontroller,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 25)),
                SizedBox(
                  width: 180,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                      Icons.date_range,
                      color: Colors.blueAccent,
                      size: 30,
                    )),
                    controller: datecontroller,
                  ),
                )
              ],
            ),

            ///*****///
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              child: DropdownButtonHideUnderline(
                child: GFDropdown(
                  padding: const EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(5),
                  border: const BorderSide(
                    color: Colors.black12,
                    width: 2,
                  ),
                  dropdownButtonColor: Colors.white,
                  icon: Icon(
                    Icons.emoji_transportation,
                    color: Colors.blueAccent,
                    size: 35,
                  ),
                  hint: Text(
                    "Time",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  value: dropdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      // dropdownValue = newValue;
                    });
                  },
                  items: [
                    'Time Out',
                  ]
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                ),
              ),
            ),
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
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
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: GFButton(
                onPressed: () {},
                text: "Submit",
                textStyle:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                blockButton: true,
                color: Colors.deepPurpleAccent,
              ),
            )
          ],
        ));
  }
}

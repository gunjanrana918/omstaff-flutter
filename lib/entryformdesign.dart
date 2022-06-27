import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:employee_attendance/universaldata.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: entryform(),
  ));
}

class entryform extends StatefulWidget {
  const entryform({Key? key}) : super(key: key);

  @override
  _entryformState createState() => _entryformState();
}

class _entryformState extends State<entryform> {
  late String dropdown;
  final bodycontroller = TextEditingController();
  var dropdownValue;
  var dropdownValue1;
  var dropdownValue2;
  String latitudedata = "";
  String longitudedata = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentlocation();
  }

  getCurrentlocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudedata = '${geoposition.latitude}';
      longitudedata = '${geoposition.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Office Entry",
            style: TextStyle(fontSize: 15.0),
          ),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10),
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            padding: const EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                                color: Colors.black12, width: 1),
                            dropdownButtonColor: Colors.white,
                            icon: const Icon(Icons.work_outlined),
                            hint: const Text(
                              "Working shift",
                              style: TextStyle(fontSize: 12.0),
                            ),
                            value: dropdownValue,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                              print(dropdownValue);
                            },
                            items: [
                              'Day',
                              'Night',
                              'Other',
                            ]
                                .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: bodycontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            suffixIcon: const Icon(
                              Icons.stacked_line_chart,
                              color: Colors.redAccent,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Body Temprature',
                            hintStyle: const TextStyle(
                                fontSize: 13.0, color: Colors.black45),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10),
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            padding: const EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                                color: Colors.black12, width: 1),
                            dropdownButtonColor: Colors.white,
                            icon: const Icon(Icons.emoji_transportation),
                            hint: const Text(
                              "Transportation mode",
                              style: TextStyle(fontSize: 12.0),
                            ),
                            value: dropdownValue1,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue1 = newValue;
                              });
                            },
                            items: [
                              'Two Wheeler',
                              'Four Wheeler - self',
                              'Four Wheeler + 1',
                              'Four Wheeler + 2',
                              'Walking',
                            ]
                                .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10),
                        child: DropdownButtonHideUnderline(
                          child: GFDropdown(
                            padding: const EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(5),
                            border: const BorderSide(
                                color: Colors.black12, width: 1),
                            dropdownButtonColor: Colors.white,
                            icon: const Icon(
                              Icons.health_and_safety,
                              color: Colors.blue,
                            ),
                            hint: const Text(
                              "Aarogya setu",
                              style: TextStyle(fontSize: 12.0),
                            ),
                            value: dropdownValue2,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue2 = newValue;
                              });
                            },
                            items: [
                              'Green: You are safe',
                              'Yellow: Moderate risk',
                              'Orange: High risk',
                              'Red: covid-19 positive'
                            ]
                                .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 3.0)),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: GFButton(
                          onPressed: () async {
                            var headers = {'Content-Type': 'application/json'};
                            var request = http.Request(
                                'POST',
                                Uri.parse(
                                    'http://api.omlogistics.co.in/office-entry-form.php'));
                            request.body = json.encode({
                              "shift": dropdownValue.toString(),
                              "temp": bodycontroller.text.replaceAll(":", ""),
                              "setu_status": dropdownValue2.toString(),
                              "lat": latitudedata,
                              "long": longitudedata,
                              "address": " ",
                              "empcode": universaladata.empcode,
                              "bcode": universaladata.BCODE,
                              "tmode": dropdownValue1.toString(),
                            });

                            request.headers.addAll(headers);
                            var response = await request.send();
                            print(response);
                            final respStr =
                                await response.stream.bytesToString();
                            var parsedJson = json.decode(respStr);
                            if (parsedJson['error'] == false) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  // title: Text("Alert Dialog Box"),
                                  content: const Text(
                                    "msg",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.blue),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        // dropdownValue = null;
                                        // bodycontroller.clear();
                                        // dropdownValue1 = null;
                                        // dropdownValue2 = null;
                                      },

                                      // Navigator.of(ctx).pop();
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: parsedJson['msg'],
                                  gravity: ToastGravity.CENTER,
                                  toastLength: Toast.LENGTH_LONG,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: Colors.white54,
                                  textColor: Colors.blue,
                                  fontSize: 15.0);
                              // dropdownValue == null;
                              bodycontroller.clear();
                              dropdownValue1 == null;
                              dropdownValue2 == null;
                            }
                          },
                          text: "Submit",
                          blockButton: false,
                          color: Colors.deepPurpleAccent,
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}

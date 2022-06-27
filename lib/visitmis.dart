import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp());
}

class visitmis extends StatefulWidget {
  const visitmis({Key? key}) : super(key: key);

  @override
  State<visitmis> createState() => _visitmisState();
}
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('dd-MMM-yyyy');
final month = DateFormat.MMMM().format(now);
final String year = now.year.toString();
final String day = now.day.toString();

class _visitmisState extends State<visitmis> {
  DateTime selectedDate = DateTime.now();
  final dateinputfrom = TextEditingController();
  final dateinputto = TextEditingController();
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
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Container(
            height: 50,
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: SizedBox(
                      height: 30,
                      child: TextField(
                        controller: dateinputfrom,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
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
                      controller: dateinputto,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
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
          Divider(
            height: 2,
            thickness: 2,
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.0,
                width: 100.0,
                child: MaterialButton(
                  elevation: 8.0,
                    child: Text(
                      'Search',
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.white),
                    ),
                    color: Colors.deepPurple,
                    onPressed: ()  {
                                         }),
              )
            ],
          ),
        ],
      ),
    );
  }

  //*****Date Selector****//
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
        // selectedDate.toString().split(' ')[0];
      }
    });
  }
}

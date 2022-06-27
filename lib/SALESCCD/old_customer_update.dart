import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class updatereport extends StatefulWidget {
  const updatereport({Key? key}) : super(key: key);

  @override
  State<updatereport> createState() => _updatereportState();
}

class _updatereportState extends State<updatereport> {
  var dropdownValue;
  var dropdownvisit;
  late String dropdown;
  final leadno = TextEditingController();
  final companyname = TextEditingController();
  final custcompaddress = TextEditingController();
  final communication = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Lead'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.redAccent.withOpacity(0.8),
                      Colors.white24,
                    ],
                    stops: const [
                      0.0,
                      1.0,
                    ]
                )
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(10.0)),
                  TextField(
                    controller: leadno,
                      decoration: InputDecoration(
                        hintText: 'Lead No.',
                        prefixIcon: Icon(Icons.add_chart,color: Colors.blue,size: 25.0,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  TextField(
                    controller: companyname,
                      decoration: InputDecoration(
                        hintText: 'Company Name',
                        prefixIcon: Icon(Icons.home_filled,color: Colors.blue,size: 25.0,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(20),
                    child: DropdownButtonHideUnderline(
                      child: GFDropdown(
                        padding: const EdgeInsets.all(15),
                        borderRadius: BorderRadius.circular(10),
                        border: const BorderSide(
                            color: Colors.black12, width: 1),
                        dropdownButtonColor: Colors.grey[300],
                        value: dropdownValue,
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: [
                          'O/S FllowUP',
                          'Pipeline',
                          'Bill Submitting',
                          'Payment Collection',
                          'Routine Visit/Business Call',
                          'New Business Opportunity Call',
                          'Other'
                        ]
                            .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  TextField(
                    controller: custcompaddress,
                      decoration: InputDecoration(
                        hintText: 'Company Address',
                        prefixIcon: Icon(Icons.location_city,color: Colors.blue,size: 25.0,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  TextField(
                      maxLines: null,
                      textAlign: TextAlign.center,
                      controller: communication,
                      decoration: InputDecoration(
                          hintText: 'Enter Communication',
                          prefixIcon: Icon(Icons.chat_outlined,color: Colors.blue,size: 25.0,),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(15),
                          )

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(20),
                    child: DropdownButtonHideUnderline(
                      child: GFDropdown(
                        padding: const EdgeInsets.all(15),
                        borderRadius: BorderRadius.circular(10),
                        border: const BorderSide(
                            color: Colors.black12, width: 1),
                        dropdownButtonColor: Colors.grey[300],
                        value: dropdownvisit,
                        onChanged: (newValue) {
                          setState(() {
                            dropdownvisit = newValue;
                          });
                        },
                        items: [
                          'First Half',
                          'Second Half',
                          'Full Day',
                        ]
                            .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  MaterialButton(
                    color: Colors.deepPurpleAccent,
                    child: Text('Create Report',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: (){
                      _updatealert(context);
                    },)

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void _updatealert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),),
            title: const Text('SUCCESS',style: TextStyle(color: Colors.green),),
            content: const Text('Successfully Created',style: TextStyle(color: Colors.red),),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => newclientt()));
                  },
                  child:  const Text('OK',style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),)),

            ],
          );
        });
  }
}

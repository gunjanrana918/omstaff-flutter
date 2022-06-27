import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MarketVehicleHiring(),
  ));
}

class MarketVehicleHiring extends StatefulWidget {
  const MarketVehicleHiring({Key? key}) : super(key: key);
  @override
  State<MarketVehicleHiring> createState() => _MarketVehicleHiringState();
}
class _MarketVehicleHiringState extends State<MarketVehicleHiring> {
  final vehiclecontroller = TextEditingController();
  final pickaddress = TextEditingController();
  final delievryaddress = TextEditingController();
  final mtype = TextEditingController();
  final mweight = TextEditingController();
  final mdimension = TextEditingController();
  final remarks = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiring Request'),
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
                      Colors.pink.withOpacity(0.3),
                      Colors.black.withOpacity(0.5),
                    ],
                    stops: const [
                      0.0,
                      1.0,
                    ]
                )
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextField(
                  controller: vehiclecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.redAccent, width: 1.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: 'No. of Vehicle'
                  ),
                )
              ],

            ) ,
          )

        ],
      ),
    );
  }
}

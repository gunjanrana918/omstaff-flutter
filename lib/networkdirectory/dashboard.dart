import 'package:employee_attendance/networkdirectory/branch_list.dart';
import 'package:employee_attendance/networkdirectory/staff_list.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(

  ));
}
class naetworkdash extends StatelessWidget {
  const naetworkdash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Directory'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Card(
              elevation: 9.0,
              shadowColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(width: 2.0, color: Colors.brown)
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const staff_list()));
                },
                child: Row(
                  children: [
                    Icon(Icons.supervised_user_circle,size: 55,color: Colors.blueAccent,),
                    Padding(padding: EdgeInsets.only(left: 28.0)),
                    Text('Staff',
                      style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
           Card(
             elevation: 9.0,
             shadowColor: Colors.purple,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(5.0),
               side: BorderSide(width: 2,color: Colors.brown)
             ),
             child: GestureDetector(
               onTap: (){
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => const branchlist()));
               },
               child:  Row(
                 children: [
                   Image.asset(
                     "images/directorycolor.png",
                     height: 65,
                     width: 60,
                   ),
                   Padding(padding: EdgeInsets.only(left: 28.0)),
                   Text('Branch',
                       style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
                 ],
               ),
             )
           ),
            Card(
              elevation: 9.0,
              shadowColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(width: 2.0, color: Colors.brown)
              ),
              child: GestureDetector(
                onTap: (){},
                child:  Row(
                  children: [
                    Icon(Icons.location_searching_rounded,size: 55,color: Colors.blue,),
                    // Image.asset('inages/updatelocation.png',
                    //   height: 65,
                    //   width: 60,
                    // ),
                    Padding(padding: EdgeInsets.only(left: 28.0)),
                    Text('Branch Location Update',
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                  ],
                ),
              )
            ),
            Card(
                elevation: 9.0,
                shadowColor: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(width: 2.0, color: Colors.brown)
                ),
                child: GestureDetector(
                  onTap: (){},
                  child:  Row(
                    children: [
                      Icon(Icons.track_changes_rounded,size: 55,color: Colors.purpleAccent,),
                      // Image.asset('inages/to_point.png',
                      //   height: 65,
                      //   width: 60,
                      // ),
                      Padding(padding: EdgeInsets.only(left: 28.0)),
                      Text('B2B Navigation',
                          style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
                    ],
                  ),
                )
            )

          ],
        ),
      ),
    );
  }
}

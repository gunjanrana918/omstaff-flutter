import 'package:employee_attendance/SALESCCD/newcustomer.dart';
import 'package:employee_attendance/SALESCCD/oldcustomer.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}
class SALESCCD extends StatefulWidget {
  const SALESCCD({Key? key}) : super(key: key);

  @override
  State<SALESCCD> createState() => _SALESCCDState();
}

class _SALESCCDState extends State<SALESCCD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales/CCD'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: (){
                _popupDialog(context);
              },
              icon: const Icon(Icons.add_box_outlined,size: 25.0,color: Colors.white,))],
      ),
    );
  }
  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),),
            title: const Text('Select Any One'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => newclientt()));
                  },
                  child:  const Text('New Customer',style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),)),
              TextButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => oldclient()));
                  },
                  child: const Text('Old Customer',style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),))
            ],
          );
            
            
            
          //   Card(
          //   margin: const EdgeInsets.all(35.0),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(5.0),
          //     side: const BorderSide(color: Colors.blue)),
          //   shadowColor: Colors.deepPurple,
          //   child: Column(
          //     children: [
          //       //const Padding(padding: EdgeInsets.all(35.0)),
          //       Container(
          //         child: 
          //         Expanded(child: child),
          //       )
          //       SizedBox(
          //         height: 20.0,
          //           child: InkWell(
          //             child: const Text('New Customer',style: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic,color: Colors.blueAccent),),
          //             onTap: (){
          //               print('hello');
          //             },
          //           )
          //       ),
          //       const Padding(padding: EdgeInsets.only(top: 10.0)),
          //       SizedBox(
          //           height: 20.0,
          //           child: InkWell(
          //             child: const Text('New Customer',style: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic,color: Colors.blueAccent),),
          //             onTap: (){
          //               print('hello');
          //             },
          //           )
          //       )
          //       // Expanded(
          //       //     child: InkWell(
          //       //       child: const Text('New Customer',style: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic,color: Colors.blueAccent),),
          //       //       onTap: (){
          //       //         print('hello');
          //       //       },
          //       //     )
          //       // ),
          //      //const Padding(padding: EdgeInsets.only(top: 5.0)),
          //      //  Expanded(
          //      //      child: InkWell(
          //      //        child: const Text('Old Customer',style: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic,color: Colors.blueAccent),),
          //      //        onTap: (){},
          //      //      )
          //      //  )
          //     ],
          //   ),
          //
          // );
          //   AlertDialog(
          //   title: Text('Alert Dialog Example !!!'),
          //   content: Text('Alert Dialog Body Goes Here  ..'),
          //   actions: <Widget>[
          //     FlatButton(
          //         onPressed: () => Navigator.of(context).pop(),
          //         child: Text('OK')),
          //     FlatButton(
          //         onPressed: () => Navigator.of(context).pop(),
          //         child: Text('CANCEL')),
          //   ],
          // );
        });
  }
}

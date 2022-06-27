import 'package:employee_attendance/DocumentManager/podupload.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(

  ));
}
class dmanagerdash extends StatelessWidget {
  const dmanagerdash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Manager'),
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
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const podupload()));
                },
                child: Row(
                  children: [
                    Icon(Icons.upload_file,size: 55,color: Colors.blueAccent,),
                    Padding(padding: EdgeInsets.only(left: 28.0)),
                    Text('POD Upload',
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
                  onTap: (){},
                  child:  Row(
                    children: [
                      Icon(Icons.receipt_rounded,size: 55.0,color: Colors.deepPurpleAccent),
                      Padding(padding: EdgeInsets.only(left: 28.0)),
                      Text('Bill Submission',
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
                      Icon(Icons.image_outlined,size: 55,color: Colors.blueAccent,),
                      // Image.asset('inages/updatelocation.png',
                      //   height: 65,
                      //   width: 60,
                      // ),
                      Padding(padding: EdgeInsets.only(left: 28.0)),
                      Text('Vehicle Image Upload',
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
                      Icon(Icons.addchart,size: 55,color: Colors.blueGrey,),
                      // Image.asset('inages/to_point.png',
                      //   height: 65,
                      //   width: 60,
                      // ),
                      Padding(padding: EdgeInsets.only(left: 28.0)),
                      Text('Investment Proof',
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


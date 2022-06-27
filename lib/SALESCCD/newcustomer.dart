import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}
class newclientt extends StatefulWidget {
  const newclientt({Key? key}) : super(key: key);

  @override
  State<newclientt> createState() => _newclienttState();
}

class _newclienttState extends State<newclientt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Lead'),
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
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(10.0)),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Visit Company Name',
                      prefixIcon: Icon(Icons.home_outlined,color: Colors.blue,size: 25.0,),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      )
                    ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  TextField(
                      decoration: InputDecoration(
                        hintText: 'Contact Person Name',
                        prefixIcon: Icon(Icons.person,color: Colors.blue,size: 25.0,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  TextField(
                      decoration: InputDecoration(
                        hintText: 'Mobile No.',
                        prefixIcon: Icon(Icons.phone_android,color: Colors.blue,size: 25.0,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail_outline,color: Colors.blue,size: 25.0,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        ),

                      )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  TextField(
                      decoration: InputDecoration(
                        hintText: 'Lead Reference',
                        prefixIcon: Icon(Icons.local_activity,color: Colors.blue,size: 25.0,),
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
                      decoration: InputDecoration(
                        hintText: 'Remarks',
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
                  MaterialButton(
                    color: Colors.deepPurpleAccent,
                    child: Text('Submit',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: (){
                      _submitalert(context);
                    },)
                ],
              )
            ),
          )
        ],
      ),
    );
  }

  void _submitalert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),),
            title: const Text('SUCCESS',style: TextStyle(color: Colors.green),),
            content: const Text('Lead Generated Successfully Against Lead No.',style: TextStyle(color: Colors.red),),
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


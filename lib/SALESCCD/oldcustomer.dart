import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}
class oldclient extends StatefulWidget {
  const oldclient({Key? key}) : super(key: key);

  @override
  State<oldclient> createState() => _oldclientState();
}

class _oldclientState extends State<oldclient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sales Lead'),
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
                      Colors.redAccent.withOpacity(0.9),
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
                      onPressed: (){},)


                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}

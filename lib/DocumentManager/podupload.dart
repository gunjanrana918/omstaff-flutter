import'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: podupload(),
  ));
}
class podupload extends StatefulWidget {
  const podupload({Key? key}) : super(key: key);

  @override
  State<podupload> createState() => _poduploadState();
}

class _poduploadState extends State<podupload> {
  final podcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POD Upload'),
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
                      Colors.redAccent.withOpacity(0.2),
                      Colors.white,
                    ],
                    stops: const [
                      0.0,
                      1.0,
                    ]
                )
            ),
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: podcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: Colors.blueGrey,width: 2)
                            ),
                            suffix: Icon(Icons.qr_code,color: Colors.blue,size: 20.0,),
                          prefixIcon: Icon(Icons.insert_chart,size: 20.0,color: Colors.blue,)
                        ),

                      ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: IconButton(
                      tooltip: 'Search',
                      onPressed: (){}, 
                      icon: Icon(Icons.search_outlined,size: 20.0,),
                    ),
                  )
                ],
              )

            ],
          )
        ],
      ),
    );
  }
}

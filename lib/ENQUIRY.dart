import 'package:flutter/material.dart';

void main (){
  runApp(MaterialApp(

  ));
}
class enquirymodule extends StatefulWidget {
  const enquirymodule({Key? key}) : super(key: key);

  @override
  State<enquirymodule> createState() => _enquirymoduleState();
}

class _enquirymoduleState extends State<enquirymodule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquiry'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[200]
            ),
            child: SingleChildScrollView(
              child:  Column(
                children: [
                  Padding(padding: EdgeInsets.all(10.0)),
                  Card(
                    shadowColor: Colors.purple,
                    elevation: 9.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Icon(Icons.model_training,size: 55.0,color: Colors.red,),
                          Padding(padding: EdgeInsets.only(left: 28.0)),
                          Text('Business Model',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.purple,
                    elevation: 9.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Image.asset('images/branchmaster.png',
                            height: 60,
                            width: 50,
                          ),
                          Padding(padding: EdgeInsets.only(left: 28.0)),
                          Text('Branch Master',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.purple,
                    elevation: 9.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Icon(Icons.receipt_outlined,size: 55.0,color: Colors.blue,),
                          Padding(padding: EdgeInsets.only(left: 28.0)),
                          Text('Bill Enquiry',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  Card(
                   shadowColor: Colors.purple,
                   elevation: 9.0,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(5.0)
                   ),
                   child: InkWell(
                     onTap: (){},
                     child: Row(
                       children: [
                         Icon(Icons.assignment,size: 55.0,color: Colors.purpleAccent,),
                         Padding(padding: EdgeInsets.only(left: 28.0)),
                         Text('CN Enquiry',
                         style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                       ],
                     ),
                   ),
                 ),
                  Card(
                    shadowColor: Colors.purple,
                    elevation: 9.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Image.asset('images/customermaster.jpg',
                            height: 60,
                            width: 50,
                          ),
                          Padding(padding: EdgeInsets.only(left: 28.0)),
                          Text('Customer Master',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.purple,
                    elevation: 9.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Icon(Icons.calculate_outlined,size: 55.0,color: Colors.brown,),
                          Padding(padding: EdgeInsets.only(left: 28.0)),
                          Text('CFT Calculator',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.purple,
                    elevation: 9.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Image.asset('images/tax.png',
                          height: 60,
                            width: 50,
                          ),
                          Padding(padding: EdgeInsets.only(left: 28.0)),
                          Text('GST Enquiry',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.purple,
                    elevation: 9.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Icon(Icons.rate_review_outlined,size: 55.0,color: Colors.blue,),
                          Padding(padding: EdgeInsets.only(left: 28.0)),
                          Text('Paid to Pay Rate Card',
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )


          )
        ],
      ),
    );
  }
}

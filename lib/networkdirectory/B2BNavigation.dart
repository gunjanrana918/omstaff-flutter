import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class BranchNavigation extends StatefulWidget {
  const BranchNavigation({Key? key}) : super(key: key);

  @override
  State<BranchNavigation> createState() => _BranchNavigationState();
}

class _BranchNavigationState extends State<BranchNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation(B2B)'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: const [
         Padding(padding: EdgeInsets.only(top: 15.0)),


        ],
      ),
    );
  }
}

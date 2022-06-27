import 'dart:async';
import 'dart:convert';
import 'package:employee_attendance/dashboard.dart';
import 'package:employee_attendance/universaldata.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: loginform(),
  ));
}

late SharedPreferences localstorage;

class loginform extends StatefulWidget {
  const loginform({Key? key}) : super(key: key);

  @override
  _loginformState createState() => _loginformState();
  static init() async {
    localstorage = await SharedPreferences.getInstance();
  }
}

class _loginformState extends State<loginform> {
  bool isMount = true;
  bool ishiddenpassword = true;
  final mobilecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  // ignore: avoid_init_to_null
  late SharedPreferences? logindata = null;
  late bool newuser;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 5), (t) {
      setState(() {
        check_if_already_login();
      });
      t.cancel(); //stops the timer
    });
  }

  @override
  void initState() {
    // startTimer();
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata?.getBool('login') ?? true);
    if (newuser == false) {
      universaladata.user_id = logindata!.getString('empcode')!;
      universaladata.Name = logindata!.getString('name')!;
      universaladata.BNAME = logindata!.getString('bname')!;
      universaladata.COMP_NAME = logindata!.getString('cname')!;
      universaladata.BCODE = logindata!.getString('bcode')!;
      universaladata.COMP_CODE = logindata!.getString('comcode')!;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const dashboard();
      }));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mobilecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(fit: StackFit.expand, children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.redAccent.withOpacity(0.1),
                    Colors.blue,
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
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                // child: Image.asset(
                //   'images/logo.png',
                // ),
              ),
              const Padding(padding: EdgeInsets.only(top: 100.0)),
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: mobilecontroller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person_rounded,
                                    color: Colors.black,
                                  ),
                                  fillColor: Colors.white54,
                                  filled: true,
                                  hintText: 'Employee Id',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.all(15.0)),
                              validator: MultiValidator([
                                RequiredValidator(errorText: '*required'),
                                // MinLengthValidator(10,
                                //     errorText: 'Id should be 5 digit')
                              ]),
                            ),
                          ),
                          TextFormField(
                              controller: passwordcontroller,
                              obscureText: ishiddenpassword,
                              decoration: InputDecoration(
                                  fillColor: Colors.white54,
                                  filled: true,
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView,
                                    child: const Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(15.0)),
                              validator:
                                  RequiredValidator(errorText: "required*")),
                          const Padding(padding: EdgeInsets.only(top: 20.0)),
                          MaterialButton(
                              elevation: 7.0,
                              color: Colors.lightBlueAccent,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              onPressed: () async {
                                // showLoaderDialog(context);
                                  var headers = {
                                    'Content-Type': 'application/json'
                                  };
                                  var request = http.Request(
                                      'POST',
                                      Uri.parse(
                                          'http://api.omlogistics.co.in/login.php'));
                                  request.body = json.encode({
                                    "user_id": mobilecontroller.text,
                                    "password": passwordcontroller.text,
                                  });
                                  universaladata.password = passwordcontroller.text;
                                  var empcode = mobilecontroller.text;
                                  // universaladata.user_id = empcode;
                                  logindata?.setString(
                                      'empcode', mobilecontroller.text);
                                  request.headers.addAll(headers);
                                  http.StreamedResponse response =
                                      await request.send();
                                  final respStr =
                                      await response.stream.bytesToString();
                                  // Navigator.pop(context);
                                  var parsedJson = json.decode(respStr);
                                  if (mobilecontroller.text.isNotEmpty &&
                                      passwordcontroller.text.isNotEmpty) {
                                  if (parsedJson['error'] == false) {
                                    logindata?.setBool('login', false);
                                   /* logindata?.setString(
                                        'empcode', universaladata.user_id);*/

                                    var name = parsedJson['user']['Name'];
                                    universaladata.Name = name;
                                    var bname = parsedJson['user']['BNAME'];
                                    universaladata.BNAME = bname;
                                    var cname = parsedJson['user']['COMP_NAME'];
                                    universaladata.COMP_NAME = cname;
                                    var bcode = parsedJson['user']['BCODE'];
                                    universaladata.BCODE = bcode;
                                    var comcode = parsedJson['user']['COMP_CODE'];
                                    universaladata.COMP_CODE = comcode;
                                    logindata?.setString(
                                        'name', universaladata.Name);
                                    logindata?.setString(
                                        'bname', universaladata.BNAME);
                                    logindata?.setString(
                                        'cname', universaladata.COMP_NAME);
                                    logindata?.setString(
                                        'bcode', universaladata.BCODE);
                                    logindata?.setString(
                                        'comcode', universaladata.COMP_CODE);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const dashboard()));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: parsedJson['msg'],
                                        gravity: ToastGravity.BOTTOM,
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              }),
                          Padding(padding: EdgeInsets.only(top: 15.0)),
                          TextButton(
                              onPressed: (){}, 
                              child: Text('Request for New Device',
                                  style: TextStyle(fontSize: 25,color: Colors.black,
                                      fontWeight: FontWeight.bold,decoration: TextDecoration.underline)))


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ]));
  }

  void _togglePasswordView() {
    setState(() {
      ishiddenpassword = !ishiddenpassword;
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

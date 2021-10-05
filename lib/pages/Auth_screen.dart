import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/both.dart';
//import 'package:my_school_app/components/Login.dart';
//import 'package:my_school_app/components/Register.dart';
import 'package:my_school_app/components/auth_service.dart';
import 'package:my_school_app/helpers/colors.dart';
import 'package:my_school_app/helpers/custom_shared_preferences.dart';
import 'package:my_school_app/pages/teacher/enter_homework.dart';
import 'package:my_school_app/pages/teacher/teacher_home.dart';
import 'package:provider/provider.dart';

import '../wrapper.dart';
import 'student/student_view.dart';

class Auth_screen extends StatefulWidget {
  const Auth_screen({Key? key}) : super(key: key);

  @override
  _Auth_screenState createState() => _Auth_screenState();
}

class _Auth_screenState extends State<Auth_screen>
    with SingleTickerProviderStateMixin {
  bool _isShowRegister = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController2 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  String check_email = "";
  var check_password = "";
  var email_sign_up = "";
  var name = "";
  var status = "";
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }


  void updateToFirebase(){
    var firebaseUser = FirebaseAuth.instance.currentUser!.email;
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("users").add({
      "email": email_sign_up,
      "status" : status.toLowerCase(),
      "name" : name,

    }).then((value) {
      print(value.id);
    });
  }


  _navigateToStudent() async {
    await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Both(),
      ),
      (route) => false,
    );
  }
  String dropdownvalue = 'Choose Status';
  var items = [
    'Choose Status',
    'Teacher',
    'Student'
  ];
  dropdown() {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
      return DropdownButton(
        value: dropdownvalue,
        icon: Icon(Icons.keyboard_arrow_down),
        items: items.map((String items) {
          return DropdownMenuItem(value: items, child: Text(items));
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
            status = newValue;
          });
        },
      );
    });
  }


  @override
  void initState() {
    super.initState();
    setUpAnimation();
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  void updateView() {
    setState(() {
      _isShowRegister = !_isShowRegister;
    });
    _isShowRegister
        ? _animationController.forward()
        : _animationController.reverse();
  }

  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    final authService2 = Provider.of<AuthService>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                AnimatedPositioned(
                  left: _isShowRegister ? -_size.width * 0.76 : 0,
                  width: _size.width * 0.88,
                  height: _size.height,
                  duration: defaultDuration,
                  child: Container(
                    color: bg,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.13),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            TextField(

                              controller: emailController,
                              onChanged: (test) {
                                check_email = test;
                                mail = test;

                              },
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: texting),
                                  fillColor: bg,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: texting))),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: TextField(
                                obscureText: true,
                                onChanged: (test) {
                                  check_password = test;
                                },
                                controller: passwordController,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: texting),
                                    fillColor: bg,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: texting))),
                              ),
                            ),
                            Spacer(flex: 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                    duration: defaultDuration,
                    left: _isShowRegister
                        ? _size.width * 0.12
                        : _size.width * 0.88,
                    height: _size.height,
                    width: _size.width * 0.88,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.13),
                        child: Form(
                          child: Column(
                            children: [
                              Spacer(),

                              TextFormField(
                                style: TextStyle(color : Colors.white,),
                                controller: emailController2,
                                onChanged: (test){
                                  email_sign_up = test;

                                },
                                decoration: InputDecoration(
                                    fillColor: button,
                                    hintText: "Email",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(color: bg))),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: TextFormField(
                                  style: TextStyle(color : Colors.white,),
                                  controller: passwordController2,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      fillColor: button,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: bg))),
                                ),
                              ),
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(color : Colors.white,),
                                decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    fillColor: button,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(color: bg))),
                              ),


                              Spacer(flex: 3)
                            ],
                          ),
                        ),
                      ),
                      color: button,
                    )),
                AnimatedPositioned(
                    duration: defaultDuration,
                    right: _isShowRegister
                        ? -_size.width * 0.06
                        : _size.width * 0.06,
                    left: 0,
                    top: _size.height * 0.1,
                    child: CircleAvatar(
                      backgroundColor: !_isShowRegister ? texting : bg,
                      radius: 25,
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _isShowRegister
                            ? Image(
                                image: AssetImage("assets/L.png"),
                                color: button)
                            : Image(
                                image: AssetImage("assets/L.png"), color: bg),
                      ),
                    )),
                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: _isShowRegister
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    left: _isShowRegister ? 0 : _size.width * 0.44 - 80,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: _isShowRegister ? texting : Colors.white,
                        fontSize: _isShowRegister ? 20 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Transform.rotate(
                        angle: -_animationTextRotate.value * pi / 180,
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            if (_isShowRegister) {
                              updateView();
                            } else {
                              authService.signInWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text);
                              // if(status=="teacher"){
                              //   _navigateToTeacher();
                              //
                              // }else{
                              //   _navigateToStudent();
                              // }
                              if (check_email == "" || check_password == "" ) {
                                final snackBar = SnackBar(
                                    content:
                                    Text('Fill all fields'));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                _navigateToStudent();
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.35),
                            decoration: BoxDecoration(
                              color: !_isShowRegister ? button : null,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            width: 160,
                            child: Text(
                              "LOGIN",
                            ),
                          ),
                        ),
                      ),
                    )),
                AnimatedPositioned(

                    duration: defaultDuration,
                    bottom: !_isShowRegister
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    right: _isShowRegister ? _size.width * 0.44 - 80 : 0,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: _isShowRegister ? texting : Colors.white,
                        fontSize: !_isShowRegister ? 20 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Transform.rotate(
                        angle: (90 - _animationTextRotate.value) * pi / 180,
                        alignment: Alignment.topRight,
                        child: InkWell(

                          onTap: () async {
                            if (!_isShowRegister) {
                              updateView();
                            } else if (_isShowRegister) {

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Sign up"),
                                    content: Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                          child: TextFormField(
                                            onChanged: (text){
                                              name = text;
                                            },
                                            style: TextStyle(color : Colors.white,),
                                            decoration: InputDecoration(

                                                fillColor: button,
                                                hintText: "Name",

                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: new BorderSide(color: bg))),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:13.0),
                                          child: dropdown()
                                        ),
                                      ],


                                    ),
                                    actions: [
                                      Wrap(
                                        children: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();

                                            },
                                          ),
                                          TextButton(
                                            child: Text("OK"),
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              await authService2.createUserWithEmailAndPassword(
                                                  emailController2.text,
                                                  passwordController2.text);
                                              updateToFirebase();
                                              final snackBar = SnackBar(
                                                  content:
                                                  Text('Created a user successfully!! '));

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);

                                            },
                                          ),

                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );

                            }
                          },
                          child: Container(

                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.35),
                            // color: red,
                            decoration: BoxDecoration(
                              color: _isShowRegister ? bg : null,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            width: 160,
                            child: Text(
                              "SIGNUP",
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            );
          }),
    );
  }
}

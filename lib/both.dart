import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/pages/student/student_view.dart';
import 'package:my_school_app/pages/teacher/teacher_home.dart';

import 'helpers/colors.dart';

class Both extends StatefulWidget {
  const Both({Key? key}) : super(key: key);

  @override
  _BothState createState() => _BothState();
}

class _BothState extends State<Both> {
  @override
  _navigateToStudent() async {
    //await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => StudentView(),
      ),

    );
  }

  _navigateToTeacher() async {
    //await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TeacherHome(),
      ),
      //(route) => false,
    );
  }

  void _onPressed() {
    Future.delayed(Duration(seconds: 4));
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance
        .collection("users")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());

        if (result.data()["status"] == "teacher") {
          print("Teacher y'all");
          _navigateToTeacher();
        }
        if (result.data()["status"] == "student") {
          print("Student duh");
          _navigateToStudent();
        }
        // result.data()["status"] == "teacher"?
        // _navigateToTeacher(): _navigateToStudent();
      });
    });
  }

  void initState() {
    Future.delayed(Duration(seconds: 4));
    _onPressed();
    super.initState();
    // print(selectedDay);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: Center(
          child: Wrap(children: [
        Text(
          "Signing you in. Just a second",
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
              fontSize: 30, fontWeight: FontWeight.w400, color: Color(0xFF23C8F7)),
        ),
            Image(
                image: AssetImage('assets/loading.gif'),
                //width: 400,
                //height : 400
            ),
      ])),
    );
  }
}

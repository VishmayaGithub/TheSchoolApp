//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/pages/student/student_view.dart';
import 'package:my_school_app/pages/teacher/enter_homework.dart';

import 'helpers/colors.dart';

class Info2 extends StatefulWidget {
  const Info2({Key? key}) : super(key: key);

  @override
  _Info2State createState() => _Info2State();
}

class _Info2State extends State<Info2> {


  _navigateToLogin() async {
    //await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => StudentView(),
      ),
          (route) => false,
    );
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Information",style: GoogleFonts.poppins(
          color: bg,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: button,
        leading: GestureDetector(
          onTap: (){_navigateToLogin();},
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,


          ),
        ),
      ),
      body: Column(
          children: [
            Image.network("https://i.gadgets360cdn.com/large/whitehatjr_1606110350914.jpg"),
            Padding(
              padding: const EdgeInsets.only(top: 68.0,left: 18,right:18),
              child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'This app is developed as a part of ',
                      style: GoogleFonts.poppins(
                        color: texting,
                        fontSize: 26,
                      ),
                    ),
                    TextSpan(
                        text: '18 under 18',
                        style: GoogleFonts.poppins(
                          color: texting,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                        )),
                    TextSpan(
                        text: ' fellowship program of',
                        style: GoogleFonts.poppins(
                          color: texting,
                          fontSize: 30,
                          // fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                        )),
                    TextSpan(
                        text: ' Whitehat junior ',
                        style: GoogleFonts.poppins(
                          color: texting,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                        ))
                  ])),
            )
          ]
      ),
    );
  }
}

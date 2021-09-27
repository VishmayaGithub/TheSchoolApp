import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/helpers/colors.dart';
import 'package:my_school_app/helpers/custom_shared_preferences.dart';
import 'package:my_school_app/components/Login.dart';
import 'package:my_school_app/components/Register.dart';
import 'package:my_school_app/pages/Auth_screen.dart';

import '../components/main_button_component.dart';

class LoginMenu extends StatefulWidget {
  const LoginMenu({Key? key}) : super(key: key);

  @override
  _LoginMenuState createState() => _LoginMenuState();
}

class _LoginMenuState extends State<LoginMenu> {

  _navigateToLogin() async {
    await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Auth_screen(),
      ),
          (route) => false,
    );
  }

  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: bg,
        body: SafeArea(
          child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 50),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Lets start our journey on the ',
                    style: GoogleFonts.poppins(
                      color: texting,
                      fontSize: 26,
                    ),
                  ),
                  TextSpan(
                      text: 'School App ',
                      style: GoogleFonts.poppins(
                        color: texting,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ))
                ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child:
                    Text('Send, correct and do your homework like never before',
                        style: GoogleFonts.poppins(
                          color: texting,
                          fontSize: 20,
                        )),
              ),
              Spacer(),
              GestureDetector(
                onTap: _navigateToLogin,
                child: Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: button,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: texting,
                      )),
                  child: Text(
                    'Get started',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: bg,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            ],
          ),
          ),
        ),
      ),
    ],
    );
  }
}

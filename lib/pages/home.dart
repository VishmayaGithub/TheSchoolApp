import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/helpers/custom_shared_preferences.dart';
import 'package:my_school_app/helpers/colors.dart';

import 'package:my_school_app/pages/onBoarding.dart';
import 'package:my_school_app/pages/LoginMenu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
   // CustomSharedPreferences.saveUserOnBoarding(false);
    _loadNavigationData();
  }

  _loadNavigationData() async {
    await Future.delayed(Duration(seconds: 4));
    await CustomSharedPreferences.checkUserOnBoarding().then((value) async {
      if (value) _navigateToLogin();
      if (!value) _navigateToOnBoarding();
    });
  }

  _navigateToLogin()async {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginMenu(),
      ),
    );
  }

  _navigateToOnBoarding() {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => OnBoardingPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/digital.png'),
                      width: 800,
                      //height : 400
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0,bottom: 18),
                      child: Text(
                        'Swift',
                        style: GoogleFonts.poppins(
                          color: texting,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0,bottom: 66),
                      child: Text(
                        'My School app',
                        style: GoogleFonts.poppins(
                          color: texting,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ),


                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "by Vishmaya",
                  style: GoogleFonts.poppins(
                    color: texting,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
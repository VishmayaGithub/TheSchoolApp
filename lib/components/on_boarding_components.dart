import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/helpers/custom_shared_preferences.dart';

import '../pages/LoginMenu.dart';
import '../helpers/colors.dart';

class OnBoardingItem extends StatelessWidget {
  final String imagePath;
  final RichText text;
  final bool? hasButton;
  const OnBoardingItem({
    Key? key,
    required this.imagePath,
    required this.text,
    this.hasButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _navigateToLogin() async {
      await CustomSharedPreferences.saveUserOnBoarding(true);
      return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginMenu(),
        ),
            (route) => false,
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Image(image: AssetImage(imagePath)),
        ),
        text,
        SizedBox(height:60),
        hasButton! ?
        GestureDetector(
          onTap: _navigateToLogin,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 64, right: 64),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color:texting,width : 2)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Go to login screen',
             style: GoogleFonts.poppins(
              color: texting,
              fontSize: 15,
            )
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Icon(Icons.arrow_forward_ios,color:texting),
              )
            ],
            ),
          ),
        ):Container(),


      ],
    );
  }

}

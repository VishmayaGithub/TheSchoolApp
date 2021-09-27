import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/components/Register.dart';

import '../helpers/colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  //final String path;
  const MainButton({
    Key? key, required this.text, required this.bgColor, required this.textColor,// required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
     // onTap: ,
      child: Container(
        padding: EdgeInsets.all(15),

        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: texting,
            )),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            color: textColor,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

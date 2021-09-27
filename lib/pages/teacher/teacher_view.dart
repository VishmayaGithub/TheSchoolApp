import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/helpers/colors.dart';

class TeacherView extends StatefulWidget {
  const TeacherView({Key? key}) : super(key: key);

  @override
  _TeacherViewState createState() => _TeacherViewState();
}

class _TeacherViewState extends State<TeacherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          SafeArea(
              child: Scrollbar(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemCount: 20,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0, bottom: 35),
                    child: Text("           Homework $index             "
                        "DueDate : ",
                        style: GoogleFonts.nunito(
                          color: button,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          //decoration: TextDecoration.underline,
                        )
                    ),
                  ),
                ),

              ),
            ),
          ))
        ],
      ),
    );
  }
}

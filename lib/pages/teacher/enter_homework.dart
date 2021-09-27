import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/components/nav.dart';
import 'package:my_school_app/helpers/colors.dart';
import 'package:my_school_app/helpers/custom_shared_preferences.dart';
import '../../info.dart';
import '../calendar2.dart';

class EnterHomework extends StatefulWidget {
  const EnterHomework({Key? key}) : super(key: key);

  @override
  _EnterHomeworkState createState() => _EnterHomeworkState();
}

class _EnterHomeworkState extends State<EnterHomework> {
  var firebaseUser = FirebaseAuth.instance.currentUser!.email;
  final firestoreInstance = FirebaseFirestore.instance;
  var hello2;

  @override
  _navigateToLogin() async {
    //await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Info(),
      ),
      (route) => false,
    );
  }

  void initState() {
    //something = "";
    _onPressed();
    print("hello");
    super.initState();
  }

  void _onPressed() async {
    firestoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        print(result.data());
        var hello2 = result.data().toString();
        print("hew");
        print(hello2);
        //hello = hello2;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text("Enter homework",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: bg,
                fontSize: 26,
                fontWeight: FontWeight.w600,
                //decoration: TextDecoration.underline,
              )),

          // actions: <Widget>[
          //   Icon(Icons.info_outlined,
          //   color: Colors.white,)
          // ],

          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                _navigateToLogin();
              },
            )
          ],
          backgroundColor: button,
        ),
        backgroundColor: bg,
        body: Container(
            child: SafeArea(
          child: Container(
            child: Calendar(),
          ),
        )));
  }
}

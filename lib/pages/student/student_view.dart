import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/components/auth_service.dart';
import 'package:my_school_app/components/nav.dart';
import 'package:my_school_app/helpers/colors.dart';
import 'package:my_school_app/info2.dart';
import 'package:provider/provider.dart';

import '../../info.dart';
import '../home.dart';

class StudentView extends StatefulWidget {
  const StudentView({Key? key}) : super(key: key);

  @override
  _StudentViewState createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  @override
  _navigateToLogin() async {
    //await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
      (route) => false,
    );
  }

  alert() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Feature not developed"),
          content: Text(
            "Sorry but right now this feature is not developed. Keep visiting for new features!!",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection("given_hw").snapshots();
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text("Home",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: bg,
                fontSize: 26,
                fontWeight: FontWeight.w600,
                //decoration: TextDecoration.underline,
              )),
          backgroundColor: button,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
                //size: 20,
              ),
              onPressed: () async {
                //_navigateToLogin();
                await authService.signOut();
                _navigateToLogin();
                //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Info2()));
              },
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: users,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Sorry something went wrong",
                style: GoogleFonts.poppins(fontSize: 30, color: texting),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading",
                  style: GoogleFonts.poppins(fontSize: 30, color: texting));
            }

            final data = snapshot.requireData;

            return ListView.builder(
              itemCount: data.size,

              //padding: const EdgeInsets.only(bottom: 12,top:12),
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: white,
                      title: Text(
                        "Homework : ${data.docs[index]["homework"]}. ",
                        style: GoogleFonts.nunito(fontSize: 20, color: texting),
                      ),
                      leading: CircleAvatar(
                          child: Image(
                              image: AssetImage(
                                  "assets/${data.docs[index]["subject"]}.png"))),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            data.docs[index]["due_date"] != ""
                                ? RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text : "Subject : ${data.docs[index]["subject"]}          ",
                                          style: GoogleFonts.nunito(
                                              fontSize: 21, color: texting,fontWeight: FontWeight.w500)

                                      ),

                                      TextSpan(
                                          text : "Given Date : ${data.docs[index]["given_date"]}   ",
                                          style: GoogleFonts.nunito(
                                              fontSize: 21, color: texting,fontWeight: FontWeight.w500)

                                      ),
                                    TextSpan(

                                        text:
                                            "Due Date : ${DateFormat.yMMMd().add_jm().format(data.docs[index]["due_date"].toDate())}",
                                        style: GoogleFonts.nunito(
                                            fontSize: 20, color: texting)),

                                  ]),

                            )
                                : Text("No due date",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        color: texting,
                                        fontWeight: FontWeight.bold)),
                            ElevatedButton(
                              onPressed: () {
                                alert();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: button,
                              ),
                              child: Text(
                                "Upload image",
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: bg,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

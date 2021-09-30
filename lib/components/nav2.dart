import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';



//import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_school_app/helpers/colors.dart';
import 'package:my_school_app/pages/Auth_screen.dart';
import 'package:my_school_app/pages/home.dart';
import 'dart:io';
//import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../info.dart';
import '../info2.dart';
import 'auth_service.dart';

class NavBar2 extends StatefulWidget {
  @override

  _NavBar2State createState() => _NavBar2State();
}

class _NavBar2State extends State<NavBar2> {


  String name = "";
  String name2 = "";
  File? _image;
  Uint8List? imageBytes;
  late String errorMsg;


  //@override
  _navigateToLogin() async {
    //await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Info(),
      ),
          (route) => false,
    );
  }










  void _onPressed() {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance
        .collection("users")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());

        //name = name2;
        this.setState(() {
          name = result.data()["name"];
        });

        Text("hello ${result.data()["name"]}");
        print(name);
      });
    });
  }


  void initState() {
    // Future.delayed(Duration(seconds: 4));
    _onPressed();
    super.initState();
    // print(selectedDay);
  }

  Future<void> storage() async {
    await Permission.photos.request();
    var firebaseUser = FirebaseAuth.instance.currentUser!.email;

    var permissionStatus = await Permission.photos.status;
    if(permissionStatus.isGranted){
      if(_image != null){
        var snapshot = await FirebaseStorage.instance.ref().child("users/$firebaseUser").putFile(_image!);

      }else{
        return;
      }
    }else{
      print("Yo grant permission");
    };

    final firestoreInstance = FirebaseFirestore.instance;

    //var firebaseUser = FirebaseAuth.instance.currentUser;



  }
  final Stream<QuerySnapshot> users =
  FirebaseFirestore.instance.collection("users").snapshots();

  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Drawer(

      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: button,
                    child: ClipOval(
                      child: SizedBox(
                          width: 180,
                          height: 180,
                          child: (_image!=null)?
                          Image.file(
                            _image!,
                            fit: BoxFit.fill,

                          ):Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVYUbi-Jf5QxIW-koSAO97ZmKrOXadXeJ3xQ&usqp=CAU",fit: BoxFit.fill,)
                      ),
                    ),
                  ),

                ),


                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.camera,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      this.setState(() {
                        _image = File(image!.path);
                      });
                    },
                  ),
                ),

              ],

            ),
            Padding(
              padding: const EdgeInsets.only(top: 23.0,right : 35),
              child: Text(name,
                  style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: texting)),
            ),
            _image != null?
            ElevatedButton(onPressed: (){storage();}, child: Text("Upload image")):Text(""),
            GestureDetector(
              onTap: ()async{
                _navigateToLogin();

              },
              child: ListTile(
                title: Text("Info",style: GoogleFonts.nunito(fontSize : 20),),  leading: Icon(Icons.info_outlined),
              ),
            ),


          ],

        ),

      ),
    );

  }

}

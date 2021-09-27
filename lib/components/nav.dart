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

import 'auth_service.dart';

class NavBar extends StatefulWidget {
  @override

  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {


  String name = "";
  String name2 = "";
  File? _image;


  //@override
  // _navigateToLogin() async {
  //   //await CustomSharedPreferences.saveUserOnBoarding(true);
  //   return Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(
  //       builder: (context) => Home(),
  //     ),
  //         (route) => false,
  //   );
  // }










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
    //_onPressed();
    super.initState();
    // print(selectedDay);
  }
  Future<void> storage() async {
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if(permissionStatus.isGranted){
      if(_image != null){
        var snapshot = await FirebaseStorage.instance.ref().child("images/image1").putFile(_image!);

      }else{
        return;
      }
    }else{
      print("Yo grant permission");
    }


  }
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection("users").snapshots();

  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final urlImage = 'https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png';
    return Drawer(
      child: Material(
        child: ListView(
         children : [
           buildHeader(urlImage : urlImage,name : name),
           Container(
             padding : EdgeInsets.symmetric(horizontal: 20),
             child: Column(children : [
           buildMenuItem(
           text: 'Sign Out',
           icon: Icons.power_settings_new_rounded,
           onClicked: () async {
             authService.signOut();
             Navigator.pop(context);
           },
         ),]),)]
          // Container(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       SizedBox(
          //         height: 20.0,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           Align(
          //             alignment: Alignment.center,
          //             child: CircleAvatar(
          //               radius: 100,
          //               backgroundColor: button,
          //               child: ClipOval(
          //                 child: SizedBox(
          //                   width: 180,
          //                   height: 180,
          //                   child: (_image!=null)?
          //                   Image.file(
          //                     _image!,
          //                     fit: BoxFit.fill,
          //
          //                   ):Image.network(
          //                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVYUbi-Jf5QxIW-koSAO97ZmKrOXadXeJ3xQ&usqp=CAU",
          //                     fit: BoxFit.fill,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //
          //       ),
          //
          //
          //           Padding(
          //             padding: EdgeInsets.only(top: 60.0),
          //             child: IconButton(
          //               icon: Icon(
          //                 FontAwesomeIcons.camera,
          //                 size: 30.0,
          //               ),
          //               onPressed: () async {
          //                 final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
          //                 this.setState(() {
          //                   _image = File(image!.path);
          //                 });
          //               },
          //             ),
          //           ),
          //
          //         ],
          //
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 23.0,right : 35),
          //         child: Text(name,
          //             style: GoogleFonts.nunito(
          //                 fontSize: 22,
          //                 fontWeight: FontWeight.w500,
          //                 color: texting)),
          //       ),
          //       _image != null?
          //       ElevatedButton(onPressed: (){storage();}, child: Text("Upload image")):Text(""),
          //       GestureDetector(
          //         onTap: ()async{
          //           await authService.signOut();
          //           Navigator.pop(context);
          //           },
          //         child: ListTile(
          //           title: Text("Log Out",style: GoogleFonts.nunito(fontSize : 20),),  leading: Icon(Icons.logout),
          //         ),
          //       ),
          //
          //
          //     ],
          //
          //   ),
          //
          // ),
        ),
      ),
    );
  }
  Widget buildHeader({
    required String urlImage,
    required String name,
   // required String email,
    //required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 4),

                ],
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.deepPurpleAccent;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

}

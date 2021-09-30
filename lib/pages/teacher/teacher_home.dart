import 'package:flutter/material.dart';
import 'package:my_school_app/components/nav.dart';
import 'package:my_school_app/helpers/colors.dart';
import 'package:my_school_app/helpers/custom_shared_preferences.dart';
import 'package:my_school_app/pages/teacher/enter_homework.dart';
import 'package:my_school_app/pages/teacher/teacher_view.dart';
class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
 EnterHomework(),

    Text(

      'No Submitted homework',
      style: optionStyle,
      textAlign: TextAlign.center,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  _navigateToTeacher() async {
    await CustomSharedPreferences.saveUserOnBoarding(true);
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => TeacherHome(),
      ),
          (route) => false,
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {  _navigateToTeacher();},
      //   backgroundColor: button,
      //   child:Icon(Icons.add,),
      // ),

      
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(

          icon: Icon(Icons.add_task_sharp ),
          label: 'Add task',
          backgroundColor: Colors.blueGrey

        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: "Submitted tasks",
        ),

      ],
        currentIndex: _selectedIndex,
        selectedItemColor: button,
        onTap: _onItemTapped,
      ),
    );
  }

}

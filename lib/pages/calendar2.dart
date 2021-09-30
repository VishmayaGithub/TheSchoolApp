import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/helpers/colors.dart';
import 'package:my_school_app/pages/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
  // _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _CalendarState extends State<Calendar> {
  String dropdownvalue = 'Choose Subject';
  var items = [
    'Choose Subject',
    'Mathematics',
    'English',
    'Biology',
    'Chemistry',
    'Physics',
    'Social science'
  ];
  Map<DateTime, List<Event>>? selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  var homework = "";
  late DateTime duedate;


  //var dropdownValue = "One";

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    print(selectedDay);
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents![date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  dropdown() {
    return DropdownButton(
      value: dropdownvalue,
      icon: Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }

  var firebaseUser = FirebaseAuth.instance.currentUser!.email;
  final firestoreInstance = FirebaseFirestore.instance;
  var subjects = "";
  void _onPressed() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    firestoreInstance.collection("given_hw").add({
      "teacher_email": firebaseUser,
      "homework": homework,
      "given_date": formattedDate,
      "due_date": duedate,
      "subject": subjects.toLowerCase().toString(),
    }).then((value) {
      print(value.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              // headerVisible: true,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,

              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusedDay);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              eventLoader: _getEventsfromDay,

              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                selectedTextStyle: TextStyle(color: Colors.black),
                todayDecoration: BoxDecoration(
                  color: button,
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: button,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: button,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ..._getEventsfromDay(selectedDay).map(
              (Event event) => Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 18, top: 8, right: 18),
                child: ListTileTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    tileColor: button,
                    //leading: Icon(Icons.delete_rounded,color: Colors.red,),
                    trailing: Wrap(children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: bg,
                                builder: (context) {
                                  return Container(
                                    height: 250.0,
                                    child: Form(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          TextField(
                                            onChanged: (test) {
                                              grade = test;
                                            },
                                            keyboardType: TextInputType.number,
                                            //inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))],
                                            maxLength: 1,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Enter grade (number)",
                                                hintStyle:
                                                    TextStyle(color: texting),
                                                fillColor: bg,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide:
                                                            new BorderSide(
                                                                color:
                                                                    texting))),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Feature not developed"),
                                                    content: Text(
                                                      "Sorry but right now sharing to a specific grade feature is not developed... Keep visiting for new features!!",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("OK"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              "Send to all students of said grade",
                                              style: TextStyle(
                                                  color: texting,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Spacer(flex: 2),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          )),
                    ]),

                    title: Text(
                      event.title!,
                      style: GoogleFonts.poppins(
                        color: bg,
                        fontSize: 22,
                        //fontWeight: FontWeight.w600,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Homework"),
            content: SingleChildScrollView(
              child: Scrollbar(
                child: Wrap(
                  children: <Widget>[
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextField(
                              controller: _eventController,
                              onChanged: (test) {
                                homework = test;
                              },
                              decoration: InputDecoration(
                                  fillColor: bg2,
                                  hintText: "Enter homework",
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: button))),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: DropdownButton(
                                value: dropdownvalue,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: items.map((String items) {
                                  return DropdownMenuItem(value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                    subjects = newValue;
                                  });
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: DateTimeFormField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Due date',
                              ),
                              mode: DateTimeFieldPickerMode.date,
                              autovalidateMode: AutovalidateMode.always,
                              validator: (e) => (e?.day ?? 0) == 1
                                  ? 'Please not the first day'
                                  : null,
                              onDateSelected: (DateTime value) {
                                duedate = value;
                              },
                            ),
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents![selectedDay] != null) {
                      selectedEvents![selectedDay]!.add(
                        Event(title: _eventController.text),
                      );
                      _onPressed();
                    } else {
                      selectedEvents![selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                      _onPressed();
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Homework"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_school_app/both.dart';
import 'package:my_school_app/pages/home.dart';
import 'package:my_school_app/pages/teacher/teacher_home.dart';
import 'package:provider/provider.dart';

import 'components/auth_service.dart';
import 'helpers/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
        stream  : authService.user,
        builder:(_, AsyncSnapshot<User?> snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            final User? user = snapshot.data;
            return user == null ?Home(): Both();
          }else{
            return Scaffold(
              body: Center(
                child : CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:my_school_app/helpers/colors.dart';

import 'package:my_school_app/helpers/colors.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            TextField(
              onChanged: (test) {
                //status = test;
              },
              decoration: InputDecoration(
                  hintText: "Status",
                  hintStyle: TextStyle(color: texting),
                  fillColor: bg,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: texting))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: texting),
                    fillColor: bg,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: texting))),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: texting),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
